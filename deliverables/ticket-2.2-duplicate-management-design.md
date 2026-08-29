# Duplicate Management Design — Ticket 2.2

**SunRise Solar · Hemayet Hossain · 25/08/2026**

Marcus's question was two questions: *how did we end up with five of everything*,
and *what stops it happening again next month*. The first has an uncomfortable
answer. The second is now built and tested in the org.

Every number and every rule state below was read back out of the org, not from
the build plan. The test output is in
`evidence/week-02/ticket-2.2-before-after-test.txt` and is reproducible with
`seed/test-duplicate-rule-before-after.apex`.

---

## ① What existed, and why it failed

Duplicate management was **already switched on** before I touched anything.
Three standard rules, all active:

```
Standard_Account_Duplicate_Rule   Account   Active   Allow + Alert + Report
Standard_Contact_Duplicate_Rule   Contact   Active
Standard_Lead_Duplicate_Rule      Lead      Active
```

And **74 Duplicate Record Sets** were already sitting in the org. Salesforce
noticed the duplicates. It flagged them, it allowed them, and nobody opened the
list.

So "turn on duplicate rules" was never the fix. Two things actually failed:

**1. The matching rule could not see the duplicates we had.** The standard
Account rule matches on fuzzy company name plus billing fields. Ticket 2.1 found
duplicates in three shapes, and only one of them is a name that looks like
another name:

| Shape | Example | Fuzzy name alone? |
|---|---|---|
| Exact-name copy | `Amelia Martin` × 4 | catches it |
| Naming-convention twin | `Amelia Martin` vs `Amelia Martin Residence` | weak |
| Middle-initial twin | `Andrew Anderson` vs `Andrew J. Anderson` | weak |

**2. The action was Allow, and nobody owned the alerts.** An alert that nobody
is rostered to read is not a control. It is a log nobody greps.

There is a third failure worth naming, because it is the one that actually
created the mess: **the 2024 import came in through the bulk API.** Duplicate
rules do run on API inserts, but a caller that sets `AllowSave` — or a bulk load
configured to ignore alerts — sails straight past an Allow+Alert rule. A rule
set to Alert cannot stop an import. Only Block can.

---

## ② The new design

Three rules on Account, in evaluation order:

| # | Rule | Matching | On create | On edit |
|---|---|---|---|---|
| 1 | Account Duplicate Rule — Phone | Phone, normalised | **Block** | Allow + alert |
| 2 | Account Duplicate Rule — Household | Name (fuzzy) + Billing Street (fuzzy) | Allow + alert + report | Allow + alert + report |
| 3 | Standard Account Duplicate Rule | stock fuzzy name + address | Allow + alert + report | Allow + alert + report |

**Why phone blocks and household only alerts.** A shared phone number is strong
evidence of the same customer — strong enough to refuse the save. A shared
address is not: a landlord and a tenant, or two flats on a subdivided block, are
two real customers at one street address. Refusing that save would make the
system wrong and the rep right, which is how people learn to work around a
system. So the household rule asks a human instead of overruling one.

**Why the phone rule matches on "normalised" and not "exact".** The 2.1 audit
found the same number written two ways — `(02) 4232 1248` and `0242321248` in
the Benjamin Walker group. An exact match treats those as different customers,
which is the precise failure the ticket exists to prevent. The rule was
originally built with Exact matching; it is now on Salesforce's normalised Phone
method. Probe 2 in the test proves the difference: `0242901310` is now caught as
a duplicate of `(02) 4290 1310`.

**Why the stock rule stays on.** I tested whether the household rule made it
redundant. It does not:

| Street written as | Household rule | Standard rule |
|---|---|---|
| `111 Sunset Rd` (exact) | catches | catches |
| `111 Sunset Road` | catches | catches |
| `111 Sunet Rd` (typo) | **misses** | catches |
| `Unit 2, 111 Sunset Rd` | **misses** | catches |

The stock rule's fuzzy matching is broader than mine and covers typos and unit
prefixes that mine does not. Keeping all three is deliberate: phone blocks,
household alerts in our own words, stock rule is the safety net underneath.

**Q3 — web form, import, or by hand?** All three run the rules. The gap is bulk
API: a load that sets `AllowSave` bypasses an *alert*, but cannot bypass a
*block*. That is the second reason the phone rule blocks. The SOP rule stands:
**imports are deduped against the phone and address keys before loading, not
after.**

---

## ③ The naming standard

> **Residential accounts are named for the person — "Amelia Martin", never
> "Amelia Martin Residence". The property lives in the address fields. One
> account per household.**

Rules enforce a standard; they cannot invent one. This is the actual fix, and it
now lives in three places a non-admin will meet it:

1. **The duplicate rule alert**, shown when a rep hits a phone duplicate
2. **The validation rule error**, shown when anyone types "Residence" into a name
3. **The Account Name field help text**, shown before they type anything

Plus this document, which is where it lives for anyone doing the next import.

**The validation rule fires only on create or when the name is edited.** This
matters: 47 of the 51 accounts in the org are still named `... Residence`. Built
without that guard — as it was this morning — the rule blocked *every* save on
those 47 records, so a rep could not update a phone number or an address without
first renaming the account. That was caught and fixed today; probe 5 in the test
is the regression check.

---

## ④ Before/after test

`seed/test-duplicate-rule-before-after.apex`, extending the Phase 0 diagnostic.
It runs two passes: `Datacloud.FindDuplicates` to show *which* rule sees each
pattern without inserting anything, then real inserts with
`DuplicateRuleHeader.AllowSave = true` — the API equivalent of clicking "Save
anyway" — so that anything still refused is a genuine block rather than a
warning.

**Before:** 300-odd account records, ~5 per household, created under Allow+Alert
rules. Ticket 2.1 is the before evidence; it does not need re-staging.

**After:**

| Probe | Pattern | Matched by | Result |
|---|---|---|---|
| 1 | phone twin, same format | Phone rule | **refused** |
| 2 | phone twin, `0242901310` vs `(02) 4290 1310` | Phone rule | **refused** |
| 3 | household twin, same address, new phone | Household + Standard | saved with alert |
| 4 | name contains "Residence" | validation rule | **refused** |
| 5 | edit legacy `... Residence` account, no rename | — | **allowed** |

Probe 3 saving is the design working, not failing: it is an alert, a human
decides, and a Duplicate Record Set is written for the review queue. Verified
separately — inserting a household twin took Duplicate Record Sets from 74 to
75. All probe records and the test's Duplicate Record Sets were deleted
afterwards; the org is back to 51 accounts and 74 sets.

---

## ⑤ Who reads the Duplicate Record Sets

The control that failed was this one, so it needs a name against it, not a
process diagram.

**Proposed: Jake, weekly, Monday morning, via App Launcher → Duplicate Record
Sets, filtered to Created Date = LAST WEEK.** Anything unresolved after two
weeks goes to Marcus. Jake is the right owner because he is the one who
verifies customer identity by phone — he is already doing the judgement this
queue needs.

**This is a proposal, not a decision.** It is in the note to Marcus, because
rostering Jake's Monday is not mine to do.

The 74 existing sets are a separate backlog from the weekly rhythm. They predate
the new rules and most refer to records that have since been merged. They should
be cleared once, then the weekly habit starts from a clean queue.

---

## What this does not fix

Written down so nobody discovers it in the Week 10 audit.

- **10 middle-initial pairs are still in the org, deliberately.** `Andrew
  Anderson Residence` / `Andrew J. Anderson Residence` and nine more, spread
  across 13 addresses that hold more than one account. Ticket 2.1 decided to
  **hold** these rather than merge them on name similarity, and put a HOLD Task
  on all twenty records due 08/09/2026. The new rules stop the *next* duplicate;
  they do not and should not clean up these. Until the pairs are confirmed by
  phone, the customer count stays bounded at 41–51.

  Worth noting what this means for the rules: the household rule **does** flag
  this pattern — probe 3 is literally an Anderson twin. Had it existed in 2024,
  these ten would have been questioned at creation rather than found two years
  later.
- **No rule catches a customer who moved house and changed phone.** Same person,
  new address, new number, no shared field. Tested and confirmed: nothing sees
  it. That needs an email or customer-number key, which we do not have.
- **47 accounts still violate the naming standard.** They are grandfathered by
  the validation rule guard. Renaming them is a data job that should happen
  alongside the merge tail, not before it — renaming first would make the
  duplicates harder to spot, not easier.
- ~~**Contact and Lead still run stock rules only.** Ticket 2.1 merged Contact
  duplicates too. The same argument probably applies there, and has not been
  made.~~

  > **Corrected 29/08/2026 — both claims were wrong. See CF-13.**
  >
  > **Ticket 2.1 never touched the Contact object.** `merge-log.md` contains no
  > occurrence of the word "contact"; the three hits in the 2.1 audit are the English
  > word. This line assumed a merge that did not happen.
  >
  > **And it is not a rules problem.** The stock Contact rule is already active with
  > Alert + Report. What is actually there: **137 Contacts, 40 distinct emails, 134
  > sitting in duplicate groups.** The queue reads 0 because duplicate rules only fire
  > on create and edit — they never scan data that already exists, and these were
  > bulk-loaded on 17/08.
  >
  > **"The same argument probably applies" to Lead does not hold either.** Zero Lead
  > duplicates on email, zero on phone, across 150 records. Building a rule on that
  > assumption is the substitution §③/§④ of the 2.1 audit records as the mistake —
  > which is why it is written down as a deliberate non-build rather than left open.
