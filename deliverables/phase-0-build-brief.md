# Phase 0 — Build the broken org

**Org:** `sunrise` · **Your time:** ~2 hours of Setup · **Do this before Week 1.**

The simulation assumes you're walking into a Salesforce org that's been neglected
for six months. Yours is brand new and pristine. So Phase 0 builds the neglect:
duplicate accounts, a quota miss with no explanation, a misrouting assignment
rule, a broken web form, and users with more access than anyone can justify.

Everything you diagnose in Weeks 1–12 gets planted here, deliberately, by you —
then forgotten. That forgetting is the point.

---

## Already done ✅

| | |
|---|---|
| 0.1 Developer org | `sunrise`, org ID `00DgK00000WyBZGUA3` |
| 0.2 Australian settings | `en_AU` · Australia/Sydney · FY starts July · Country Australia |

Two checks worth doing yourself, because I can't verify them remotely:

- `Setup → Company Information` → **Currency Locale** reads Australian Dollar
- `Setup → Deliverability` → **Access level: All email**

That second one is not optional. Leave it on "System email only" and every
auto-response rule you build in Weeks 4 and 8 vanishes silently, and you will
lose an evening to it.

---

## 0.3 · Clear the stock sample data

*(Claude runs this — say the word)*

A fresh Developer org ships with sample records:

| Object | Records |
|---|---|
| Opportunity | 31 |
| Case | 26 |
| Lead | 22 |
| Contact | 20 |
| Account | 13 |
| Campaign | 4 |

The Opportunities are the problem. Week 3 asks you to explain a quota miss from
seeded data with a deliberate 12% decline in average deal size. Thirty-one
unrelated Opportunities in the same date range make every number you report
wrong, and you would not know why.

The 17 sample **Products stay** — they cost nothing and Week 4's campaign work
can use them.

---

## 0.4 · Add the one field the seed needs

`Setup → Object Manager → Account → Fields & Relationships → New`

**Picklist**, label `Service Region`, API name `Service_Region__c`, values:

```
Sydney
Newcastle
Wollongong
```

Tick **Restrict picklist to the values defined in the value set**. Add it to the
Account page layout.

In the story this is a field Alex built before he left. In practice it gives
Week 3 a regional dimension to analyse — the seeded revenue decline is
concentrated in Newcastle, and without this field you cannot find that.

---

## 0.5 · Create the cast

`Setup → Users → New User`. You have **2 free Salesforce licences and 6 Platform**.

| User | Licence | Why |
|---|---|---|
| **Jack Nguyen** — Sydney sales rep | Salesforce | Owns Opportunities. Week 3 needs at least two owners to compare. |
| **Mia Kelly** — Newcastle sales rep | Salesforce | Carries the seeded decline. |
| **Alan Brooks**, **Lisa Fernandez** | rotate | The Week 1.2 leavers. Create, let them own records, deactivate as the exercise. |

Set the **Manager** field on both reps. Week 5's discount approval routes to the
manager, and an empty Manager field is the most common reason an approval process
silently fails.

Timezone Australia/Sydney, locale English (Australia) on every one.

**Licence rotation trick:** deactivating a user frees the licence, and an inactive
user *keeps* records they already own. So you can create a rep, let the seed give
them deals, deactivate, and create the next. You cannot assign *new* records to an
inactive user — order matters.

---

## 0.6 · Switch on duplicate management BEFORE seeding

**This is the step people get wrong, and getting it wrong costs you Week 2 entirely.**

Salesforce only creates a Duplicate Record Set when a duplicate rule fires **on
save**. It never scans records that already exist. Seed first and you end up with
150 duplicate Accounts and nothing in the org that knows they're duplicates.

1. `Setup → Matching Rules` → **Standard Account Matching Rule** → **Activate**
   Wait for the activation email. Indexing takes a few minutes on a new org.
2. `Setup → Duplicate Rules` → **Standard Account Duplicate Rule** → confirm the
   action on **Create** is `Allow` with **Report** ticked — *not* `Block`.
   If it blocks, the seed throws `DUPLICATES_DETECTED` and inserts nothing.

Tell me when both are active. The seed depends on it.

---

## 0.7 · Run the four seed scripts

*(Claude runs these, after 0.4 and 0.6)*

| Script | Creates | Feeds |
|---|---|---|
| `01-accounts-and-duplicates` | 150 households + 150 duplicates in four dirty patterns | Week 2 |
| `02-closed-opportunity-history` | Two quarters of closed business with a deliberate decline | Weeks 3, 9 |
| `03-open-pipeline-and-cases` | Open pipeline, 140 service cases | Weeks 3, 8, 9 |
| `04-campaigns-and-leads` | Six campaigns totalling $180k spend, leads, members | Week 4 |

Script 02 prints revenue by quarter when it finishes. **Write those numbers down.**
The Apr–Jun 2026 figure is your actual; × 1.17 is the quota Marcus quotes at you
in Week 3. A Developer org can't hold four quarters of an $18M business, so your
org is a faithful scale model — the ratios hold, the dollars are smaller.

---

## 0.8 · Plant the three bugs

Build these now and forget how. In Weeks 4, 5 and 10 you diagnose them cold.

### The misrouting lead assignment rule — breaks Week 5.1

`Setup → Lead Assignment Rules → New` → `NSW Territory Routing` → **Active**

Three entries, **in this order**:

| Order | Criteria | Assign to | |
|---|---|---|---|
| 1 | Postal Code **starts with** `2` | Jack (Sydney) | ← **the bug** |
| 2 | Postal Code between 2280–2340 | Mia (Newcastle) | correct, unreachable |
| 3 | Postal Code between 2500–2541 | Wollongong rep | correct, unreachable |

Entry 1 catches every NSW postcode, so 2 and 3 never evaluate. Assignment rules
stop at the first match. Jake's Week 5 complaint — *"my Newcastle reps have been
getting Sydney leads for 3 weeks"* — becomes literally true, with a root cause
that happens in real orgs constantly: rule entry order.

### The broken web form — breaks Week 4.2

`Setup → Web-to-Lead → Create Web-to-Lead Form`. Save the generated HTML as
`seed/webform.html`. Then break it twice, because real failures are rarely
single-cause:

- Create a Lead Auto-Response Rule and **leave it inactive**. Customers get no
  acknowledgement — exactly what Sarah's callers complain about.
- **Delete the State field** from the generated HTML. Web leads now arrive with
  no state, fall through your assignment rule, and land on the default owner.

Set `Setup → Lead Settings → Default Lead Owner` to yourself so the orphans pile
up somewhere visible.

### The over-permissioned users — breaks Week 10.1

A security audit with nothing to find teaches nothing.

- Give one non-admin user the **System Administrator** profile
- `Setup → Permission Sets → New` → `Legacy Reporting Access` → System
  Permissions → **View All Data** + **Export Reports** → assign it to a sales rep

Name it like it's historical. In Week 10 the finding writes itself: a permission
set nobody can explain, granting data access nobody reviewed.

---

## 0.9 · The habit that makes the portfolio

Screenshot the **before** state every single week, into `evidence/`.

It costs thirty seconds, it's unrecoverable once you've fixed the thing, and
"here's what they had, here's what I gave them" is the most persuasive slide in
your Week 12 deck. Log every change in `deliverables/build-log.md` as you go —
date, component, change, why.

---

## Order of operations

```
  0.3  purge sample data          Claude
  0.4  Service_Region__c          you
  0.5  create users               you
  0.6  activate duplicate rules   you    ← must precede 0.7
  0.7  run seed scripts           Claude
  0.8  plant the three bugs       you
  0.9  start the evidence habit   you
```

Steps 0.4, 0.5 and 0.6 are yours and independent — do them in any order. Tell me
when 0.6 is active and I'll run the seed.
