# Ticket 2.3 — Phase 0 baseline: the damage, measured

**Captured:** 25/08/2026 · **Org:** `sunrise` · **Source:** SOQL and the saved report,
cross-checked against each other

Everything below was read back from the org. Where it contradicts the Week 2 brief,
the org wins and the difference is stated.

---

## The headline number

| | |
|---|---|
| Open Opportunities with a Close Date in the past | **55** |
| Value of those | **$692,352** |
| Total open pipeline | **$1,898,880** (150 opps) |
| **Share of open pipeline that is already past its own close date** | **36.5%** |
| Forecast category of all 55 | **Pipeline — every one is in the forecast right now** |

**This is the number that is lying to Marcus's forecast: $692,352, which is 36.5 cents
in every dollar Jake is about to quote.**

Forecast exposure was verified, not assumed: `ForecastCategoryName` is `Pipeline` on
all 55, with no exceptions.

### Cross-check

The saved report and the SOQL query were run independently and agree exactly:

```
Report "Pipeline Hygiene - Stale Open Opps"   →  55 rows, grand total $692,352.00
SOQL COUNT(Id) / SUM(Amount)                  →  55,               692352
```

---

## The brief said 51. The org says 55.

Not a discrepancy — **drift**. Exactly 4 Opportunities crossed their own close date
between 21/08 (when the brief was verified) and today, without anyone touching
anything:

```
open AND CloseDate >= 2026-08-21 AND CloseDate < TODAY  →  4
```

That is the most important thing in this baseline. The stale list is not a fixed
backlog to be cleared once — **it refills on its own at roughly one Opportunity a
day.** A further 31 open Opportunities have a close date inside the next 30 days and
will start arriving in this list from tomorrow.

This is the argument for Phase 3 (automate the nag) over Phase 1 (triage the list).
Triaging 55 records by hand fixes today and is stale again by Friday.

---

## Both inputs the Phase 1 triage rule depends on are missing

The build guide's Phase 1 sorts every Opportunity into CLOSE / RE-DATE / ASK OWNER
using two signals. Neither exists in this org.

### 1. There is no activity history at all

```
Opportunities with LastActivityDate populated   →  0   (of all 890, not just the 55)
Event records in the org                        →  0
Task records related to an Opportunity          →  0
```

The org holds 26 Tasks in total, and all 26 are the ones **I** created during Ticket
2.1 (6 bucket-C address confirmations + 20 middle-initial HOLDs). There is no sales
activity in this org whatsoever.

- CLOSE requires *"no activity 60+ days"* — unmeasurable.
- RE-DATE requires *"activity within 30 days"* — unmeasurable.

### 2. Nothing is more than 90 days past its close date

```
more than  7 days past close  →  48   ($608,768)
more than 14 days past close  →  41   ($519,296)
more than 30 days past close  →  25   ($308,608)
more than 45 days past close  →  10   ($130,048)
more than 60 days past close  →   0
more than 90 days past close  →   0
```

Close dates run 01/07/2026 → 24/08/2026. The oldest is **55 days** past. The
newest is *yesterday*.

CLOSE requires *"Close Date >90 days past"* — **zero records qualify.**

### What that does to the triage

CLOSE takes nothing. RE-DATE takes nothing. ASK OWNER is defined as "everything
between", so **all 55 fall into a single bucket**. The three-way recommendation the
deliverable asks for cannot be produced from the rule as written.

Jake's own premise is also slightly off: he wrote *"stuff in there from months ago
that's definitely dead."* Nothing here is from months ago, and nothing in the data
says "dead" — only "past its date".

---

## ASK OWNER is undeliverable for 76% of the list

The one bucket everything falls into is the one that cannot be actioned.

| Owner | Opps | Value | Can they be asked? |
|---|---|---|---|
| OrgFarm EPIC | 15 | $178,432 | **No — deactivated 19/08 in Ticket 1.1** |
| Mia Kelly | 14 | $180,992 | **No — has never logged in** |
| Jack Nguyen | 13 | $156,160 | **No — has never logged in** |
| Hemayet Hossain | 13 | $176,768 | Me. The admin, not a sales rep |
| **Unreachable total** | **42** | **$515,584** | **74.5% of the stale value** |

`LastLoginDate` is null for Jack and Mia; `IsActive` is false for OrgFarm EPIC.

**Not one of these 55 Opportunities is owned by a working salesperson.** The 15
owned by a deactivated user are the sharpest case — Ticket 1.1 deactivated OrgFarm
EPIC to recover a licence and the deactivation left $178,432 of forecast behind it.
Deactivating a user does not reassign their pipeline.

---

## Phase 3 is blocked, and it is the Week 1 blocker again

The build guide's Phase 3 says *"subscribe Jake to the report."*

**Jake has no user account in this org.** Nor does Marcus. The full active user list
is Hemayet, Ben Carter, Jack Nguyen, Mia Kelly, Priya Sharma, and five platform
service accounts. Report subscriptions can only be sent to users, roles or groups
that exist, so there is nobody to subscribe.

The reason Jake has no account is the same unanswered licence decision that has
blocked two new hires and Priya's Campaign access since Week 1 — Salesforce licences
are 4 of 4 used, and 2 of those 4 are held by Jack and Mia, who have never logged in.

This ticket is the third request blocked on that one decision.

---

## Other measurements taken while in the data

**Stage** — every one of the 55 is early-stage. None have reached Proposal or
Negotiation:

| Stage | Opps | Value |
|---|---|---|
| Id. Decision Makers | 16 | $197,632 |
| Qualification | 15 | $190,848 |
| Needs Analysis | 15 | $191,744 |
| Prospecting | 9 | $112,128 |

These are not late-stage deals that slipped. They are early-stage deals that were
never worked — which supports "dead" more than the age figures do.

**`CreatedDate` is worthless as an age signal.** All 890 Opportunities in the org
were created inside an 8-second window on 17/08/2026 by the seed import. The build
guide lists Created Date as a triage column; it carries no information here.

---

## Artefacts

| What | Where |
|---|---|
| Full 55-row export (12 fields) | `evidence/week-02/stale-open-opportunities.csv` |
| Saved report | **Pipeline Hygiene - Stale Open Opps**, folder *SunRise Ops*, Id `00OgK00000Dh8inUAB` |
| Report source | `force-app/main/default/reports/SunRise_Ops/Pipeline_Hygiene_Stale_Open_Opps.report-meta.xml` |

The report carries two columns beyond the build guide's list, both earning their
place from the findings above:

- **Opportunity Owner: Active** — makes the deactivated-owner problem visible on the
  report itself rather than only in this document.
- **Forecast Category** — shows the reader that every row is in the forecast, which
  is the whole reason the report matters.

**Last Activity** is on the report as specified, and is deliberately left there
despite being empty on every row: a blank column is the visible evidence of the gap.

---

## What Phase 1 has to answer before it can run

1. With no activity data and nothing past 90 days, what actually replaces the
   three-way rule? Days-past-close alone is the only signal the org has.
2. Who triages the 42 Opportunities whose owners cannot be asked — and does that
   pipeline get reassigned to a real rep before it is judged?
3. Does anything get recommended for CLOSE at all when no record meets the CLOSE
   criterion?

Per [sop-escalating-rule-changes.md](../../deliverables/sop-escalating-rule-changes.md),
the rule broke on contact with the data, so this goes to Jake and Marcus **before**
Phase 1 proceeds, not in the write-up afterwards.
