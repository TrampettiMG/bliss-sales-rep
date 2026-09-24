# QuickBase — a quick visual guide

The QuickBase screens you'll use most, in the order you'll usually need them. Customer names, contacts,
reps, IDs and dollar amounts are blurred — your screens will show your own data.

## 1. Your leads — New/Pending Opportunities

![New/Pending Opportunities report](docs/quickbase/1-new-opportunities.png)

Your dashboard home page shows your own new and pending opportunities — your unworked leads. Always start
from **Opportunities**, not Quote Pipeline (that's the older tab).

## 2. An opportunity record

![Opportunity record](docs/quickbase/5-opportunity-record.png)

Think of an Opportunity as a file-cabinet folder — one per piece of business, with its quote(s) inside.
Payment Terms, Cooperative Contract and Offer Financing live here. If co-op or financing doesn't apply,
pick "N/A" or "No" — don't leave it blank.

## 3. Red text = Revision Needed

![Revision Needed red text](docs/quickbase/3-revision-needed.png)

Red text on an opportunity lists exactly what's missing (here, Cooperative Contract). Fill in each field it
names and it clears on its own. Until it does, the quote can't move to Order Submitted.

## 4. Your forecast — Rep Forecast Current Period (or Before)

![Rep Forecast report](docs/quickbase/2-rep-forecast-report.png)

Where you see and update Forecast Close Date, Confidence and Today Opp Update for each opportunity. The
Revision Needed column shows red text for anything missing.

## 5. Updating many at once — Grid edit

![Grid edit menu](docs/quickbase/4-rep-forecast-grid-edit.png)

On the forecast report, open the **☰ menu** at the top right and pick **Grid edit** to update a lot of
opportunities at once. The `forecast-update` tool gets your values ready to paste straight in.

## 6. Copying an opportunity — the blue button (COPY tab)

![COPY tab with the blue button](docs/quickbase/8-copy-tab-blue-button.png)

On the opportunity, open the **COPY** tab and click the blue **Copy Opp - Select Quotes** button, then pick
the quote(s) to bring along. Only the Opportunity Name, Bid Type and Sales Rep 1 copy over — fill in the
rest. Refresh the page (Ctrl+R); the copy can take up to 30 seconds to appear.

## 7. Don't copy from the three-dot menu

![Three-dot menu — don't use Duplicate](docs/quickbase/6-three-dot-menu.png)

**Don't use "Duplicate this Opportunity"** in the three-dot (…) menu. It drops most of the fields and makes
a mess. Use the blue button on the COPY tab instead.

## 8. Moving a quote to another opportunity — the yellow button

![Move Quote to Another Opportunity button](docs/quickbase/9-quote-move-quote-button.png)

On the quote, in the Opportunity/Customer section, click the yellow **Move Quote to Another Opportunity**
button. No need to close the quote and start over.

## 9. Copying a quote — the purple button

![Copy Quote for this Opportunity button](docs/quickbase/11-copy-quote-purple-button.png)

To copy a quote within the same opportunity (for example, to present options), click the purple **Copy
Quote for this Opportunity** button on the quote.

**Don't use More ▾ → "Copy this Quote"** instead — that's the built-in copy and drops most of the fields.

![Quote More menu — don't use Copy this Quote](docs/quickbase/10-quote-more-menu-native-copy.png)

## 10. Adding a quote

![Quotes section with Add Quote](docs/quickbase/7-opportunity-quotes-section.png)

Add a quote from the Quotes section of the opportunity. The **Add Quote** button only appears once
"Quoted to Customer - Missing Required" is blank, so clear any Revision Needed items first.
