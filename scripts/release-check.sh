#!/bin/bash
# Read-only release checks for the public Bliss Training repo.
set -u

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root" || exit 1

fails=0
reviews=0

fail() {
  printf 'FAIL|%s\n' "$1"
  fails=$((fails + 1))
}

review() {
  printf 'REVIEW|%s\n' "$1"
  reviews=$((reviews + 1))
}

qb='skills/quickbase-usage/SKILL.md'
description=$(awk '
  NR == 1 && $0 == "---" { front = 1; next }
  front && $0 == "---" { exit }
  front && /^description:/ {
    found = 1
    sub(/^description:[[:space:]]*/, "")
    if (length($0)) print
    next
  }
  front && found {
    if ($0 !~ /^[[:space:]]/) exit
    sub(/^[[:space:]]+/, "")
    print
  }
' "$qb" | tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//')
description_length=${#description}
printf 'quickbase description length: %s\n' "$description_length"
if [ "$description_length" -ge 1024 ]; then
  fail "$qb:3: description length $description_length is not less than 1024"
fi

version_lines=$(grep -nE '^\*\*Tools version: .*\*\*$' CLAUDE.md || true)
version_count=0
if [ -n "$version_lines" ]; then
  version_count=$(printf '%s\n' "$version_lines" | wc -l | tr -d ' ')
fi
if [ "$version_count" -eq 1 ]; then
  printf '%s\n' "$version_lines"
else
  fail "CLAUDE.md: Tools version line count is $version_count, expected exactly 1"
  [ -n "$version_lines" ] && printf '%s\n' "$version_lines"
fi

tracked_files() {
  git ls-files --cached --others --exclude-standard | while IFS= read -r file; do
    case "$file" in
      private/*|scripts/release-check.sh) continue ;;
      *) printf '%s\n' "$file" ;;
    esac
  done
}

check_pattern() {
  kind=$1
  regex=$2
  while IFS= read -r file; do
    [ -f "$file" ] || continue
    matches=$(grep -nIE "$regex" "$file" 2>/dev/null || true)
    [ -n "$matches" ] || continue
    while IFS= read -r match; do
      line=${match%%:*}
      text=${match#*:}
      if [ "$kind" = FAIL ]; then
        fail "$file:$line: $text"
      else
        review "$file:$line: $text"
      fi
    done <<EOF
$matches
EOF
  done < <(tracked_files)
}

check_pattern FAIL 'Opp (#[0-9]{4,}|[0-9]{3,})([^/0-9]|$)'
check_pattern FAIL 'rid=[0-9]+'
check_pattern FAIL 'RFQ[ #-]*[0-9]{3,}'
check_pattern FAIL 'Quote #?[0-9]{4,}'
check_pattern REVIEW '\$[1-9][0-9,.]*[KkMm]?'

if [ -f private/scrub-names.txt ]; then
  while IFS= read -r name || [ -n "$name" ]; do
    [ -n "$name" ] || continue
    while IFS= read -r file; do
      [ -f "$file" ] || continue
      matches=$(grep -nIFiw -- "$name" "$file" 2>/dev/null || true)
      [ -n "$matches" ] || continue
      while IFS= read -r match; do
        line=${match%%:*}
        text=${match#*:}
        fail "$file:$line: $text"
      done <<EOF
$matches
EOF
    done < <(tracked_files)
  done < private/scrub-names.txt
else
  printf 'names check skipped (no private/scrub-names.txt)\n'
fi

setup_matches=$(grep -nIF -- private SETUP.md 2>/dev/null || true)
if [ -n "$setup_matches" ]; then
  while IFS= read -r match; do
    line=${match%%:*}
    text=${match#*:}
    review "SETUP.md:$line: $text"
  done <<EOF
$setup_matches
EOF
fi

while IFS= read -r url; do
  [ -n "$url" ] || continue
  rel=${url#https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/}
  if [ ! -f "$rel" ]; then
    fail "CLAUDE.md: missing listed file $rel"
  fi
done < <(grep -Eo 'https://raw.githubusercontent.com/TrampettiMG/bliss-sales-rep/main/skills/[A-Za-z0-9_./-]+\.md' CLAUDE.md | sort -u)

printf 'Summary: FAIL=%s REVIEW=%s\n' "$fails" "$reviews"
if [ "$fails" -gt 0 ]; then
  exit 1
fi
exit 0
