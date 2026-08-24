# "301 customers" exposure check

**Org:** `sunrise` · **Run:** 25 August 2026 · **By:** Hemayet Hossain
**Question:** has the figure of 301 customers been baked into, or quoted in,
anything inside the org — such that correcting it to 41 households would be a
**restatement** rather than a data cleanup?

---

## Finding

> **No customer count has been published, quoted or embedded anywhere in this org.**
>
> The 301 figure existed only as a **record count returned by an ad-hoc report**.
> It has never been written into a document, an email template, a dashboard, or a
> Chatter post. Correcting it is a data cleanup, not a restatement.

**This does not clear the question outside Salesforce.** See *Limits* below.

---

## What was searched

| Source | Objects queried | Records | References to a customer count |
|---|---|---|---|
| Reports | `Report` | 31 | **None** |
| Dashboards | `Dashboard` | 2 | **None** |
| Documents | `Document` | 2 | **None** |
| Files | `ContentVersion` | 3 | **None** |
| Email templates | `EmailTemplate` (incl. `Body`, `HtmlValue`) | 28 | **None** — see false positives |
| Chatter | `FeedItem` (incl. `Body`) | 193 | **None** — one related post, no count |

### Reports — 31 total, none aggregate Accounts for a count

- **24 are Salesforce Enablement reports** (`*_sfdcSESv60` / `v61`) about exercise
  and milestone completion. No Account content.
- **6 are stock Flow/Orchestration sample reports** in Public Reports.
- **1 is mine:** `AUDIT All Accounts 21-08-2026`, Tabular, **Private Reports**
  folder, created 21/08 as the Ticket 2.1 export. Tabular — it lists Accounts, it
  does not total them, and it is in a private folder nobody else can see.

**No report groups, counts or summarises Accounts.** The 301 figure came from
running a list and reading the row count, not from a saved metric.

### Dashboards — 2, both stock

Both are the Salesforce **Enablement Dashboard** (Spring '24 and Summer '24),
shipped with the org. Neither contains an Account component.

### Email templates — 28, and the "301" hits are a colour code

Ten templates matched a raw search for `301`. **All ten are false positives:** the
string appears inside the CSS hex colour `#d79301` in Salesforce Scheduler's stock
templates.

```
... border-top: 5px solid #d79301; ...
```

A pattern search for *a number followed by* `customers` / `accounts` / `clients`
returned **zero** matches across all 28 templates.

### Chatter — 193 posts, one relevant, no number

A single post mentions customers — my own, 23/08, recording the merge rule for
Marcus's approval:

> *"Two Accounts are the same customer when their phone numbers match; the surviving
> record is the one with the most recent won Opportunity; any group…"*

That states a **rule**, not a count. No post anywhere quotes a customer total.

### Documents and Files

- `AddressDiscovery_2025-02-20 0105.txt` and `…1233.txt` — 2,088 bytes each,
  created 11/08 with the org. Stock artefacts, not SunRise content.
- `Duplicate Inventory v1` (×2, Excel) and `evidence.week2` (PNG) — my own Ticket
  2.1 working files.

---

## Limits of this check

**This covers the Salesforce org only.** Three places the figure could still be
quoted that no SOQL query can reach:

1. **The board pack itself**, and any prior version — held outside Salesforce.
2. **Email sent from personal or Outlook accounts** rather than through Salesforce.
3. **Marketing material, the website, or funding conversations.**

**Recommended:** Marcus confirms none of the above quoted a customer figure. That
is a two-minute question to him and it closes the last route to a restatement.

**Also worth noting:** `EmailTemplate.Body` and `FeedItem.Body` **cannot be
filtered in SOQL** — both return `field 'Body' can not be filtered in a query
call`. Both were therefore retrieved in full and scanned client-side, which is why
the counts above are exact rather than sampled.

---

## Conclusion for the board pack

The 301 figure was never a published number. It was a row count from an ad-hoc
list, repeated verbally. Nothing in the org derives from it, and no downstream
metric moves when it is corrected.

**The correction can be presented as a data-quality finding, not a restatement** —
provided Marcus confirms the figure was never quoted outside Salesforce.
