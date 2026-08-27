# Carry-forward tickets — Weeks 1 and 2

**Raised 27/08/2026 · Before Week 3 opens · Org `sunrise`**

Everything below was verified against the org today, not copied forward from notes.
Nothing here is "tidy-up": each item is either a commitment already made to someone,
a decision blocking other work, or a gap that will be found by the Week 10 audit if
it is not found sooner.

**20 tickets. 3 are overdue or due today. 5 are blocked on Marcus. 4 can only be
written by Hemayet.**

---

## How to read this

| Status | Meaning |
|---|---|
| 🔴 **DUE** | Dated commitment, at or past its date |
| 🟠 **BLOCKED** | Cannot proceed without a named person's decision |
| 🟡 **READY** | Actionable now, no decision needed |
| 🔵 **DEFERRED** | Deliberately not done, with a reason and a date |

---

## Register

| # | Ticket | From | Status | Blocked on |
|---|---|---|---|---|
| CF-01 | The customer-count freeze point passes today | W2 · 2.1 | 🔴 DUE | Hemayet |
| CF-02 | Six bucket-C address confirmations due today | W2 · 2.1 | 🔴 DUE | Field contact |
| CF-03 | Licence decision — Salesforce is 4 of 4 | W1 · 1.1 | 🟠 BLOCKED | Marcus |
| CF-04 | Who inherits the 666 unowned Opportunities | W2 · 2.3 | 🟠 BLOCKED | Marcus |
| CF-05 | Stale-pipeline threshold: 30 days or 14 | W2 · 2.3 | 🟠 BLOCKED | Marcus |
| CF-06 | Confirm Block-on-create for duplicate accounts | W2 · 2.2 | 🟠 BLOCKED | Marcus |
| CF-07 | Roster an owner for the duplicate queue | W2 · 2.2 | 🟠 BLOCKED | Marcus |
| CF-08 | Four unwritten sections in the provisioning SOP | W1 · 1.1 | 🟠 BLOCKED | Hemayet |
| CF-09 | The freeze-vs-deactivate paragraph | W1 · 1.2 | 🟠 BLOCKED | Hemayet |
| CF-10 | Dormant-user review: the send decision | W1 · 1.2 | 🟠 BLOCKED | Hemayet |
| CF-11 | Zara's reply: the three-sentence version | W1 · 1.3 | 🟠 BLOCKED | Hemayet |
| CF-12 | Jack and Mia have no role | W1 · 1.1 | 🟡 READY | — |
| CF-13 | Contact and Lead still run stock rules only | W2 · 2.2 | 🟡 READY | — |
| CF-14 | Week 1 evidence was never captured | W1 | 🟡 READY | — |
| CF-15 | The role hierarchy is Salesforce's US sample | W1 · 1.1 | 🟡 READY | — |
| CF-16 | Default owner fields all point at the admin | W1 · 1.1 | 🟡 READY | — |
| CF-17 | Ben's Manager is a placeholder | W1 · 1.1 | 🔵 DEFERRED | Real reporting line |
| CF-18 | `Marketing Campaign Access` permission set | W1 · 1.3 | 🔵 DEFERRED | CF-03 |
| CF-19 | 47 accounts still violate the naming standard | W2 · 2.2 | 🔵 DEFERRED | CF-20 |
| CF-20 | Ten middle-initial pairs, held for confirmation | W2 · 2.1 | 🔵 DEFERRED | 08/09/2026 |

---

# 🔴 Due now

## CF-01 — The customer-count freeze point passes today

**From:** Ticket 2.1 · **Owner:** Hemayet · **Due: COB today, 27/08/2026**

The build log records a commitment made to Marcus:

> *"Freeze point committed: ten initial-pairs resolved by COB Thursday 27/08/2026,
> ahead of the month-end board pack."*

**That is today, and it will not be met.** The ten pairs are deliberately HELD
(CF-20), and the Tasks that would resolve them are dated **08/09/2026** — twelve days
after the date promised to Marcus.

**These two dates have been inconsistent since 25/08 and nobody has noticed.** That is
the actual finding: the commitment and the mechanism to deliver it were set up on the
same day, pointing at different dates.

**The customer count therefore stays a range: 41–51 households.** That is defensible —
the reconciliation and the bounds are documented in the audit — but Marcus was told it
would be a single number by today.

**Action:** tell Marcus today, before he needs it, that the number stays a range and
why. Either move the freeze point to 08/09 to match the Tasks, or pull the Task due
dates forward. **Do not resolve it by merging the pairs on name similarity** — that is
the exact substitution Ticket 2.1 §③ and §④ already record as a mistake.

The cheap version is one line, today: *"The 41–51 range holds for the board pack — the
ten pairs need a phone confirmation and that lands 08/09, not today. Range with the
arithmetic behind it, or do you want me to chase the confirmations this week?"*

---

## CF-02 — Six bucket-C address confirmations due today

**From:** Ticket 2.1 · **Due: 27/08/2026** · **Status in org: 6 Tasks, all Not Started**

Six accounts were merged where the surviving address was chosen by **record age, not
evidence** — no won Opportunity existed to discriminate. Each carries a high-priority
Task: *"Confirm service address before next job — address chosen by record age during
dedupe."*

| Account | Surviving address |
|---|---|
| Andrew J. Anderson Residence | Campbelltown |
| Daniel J. Clark Residence | Campbelltown |
| Joshua J. Patel Residence | Penrith |
| Lucas J. Tran Residence | Chatswood |
| Samuel J. Fitzgerald Residence | Chatswood |
| Oliver J. Murphy Residence | Campbelltown |

**Why it matters more than a task date:** the discarded addresses are unrecoverable
from the org, and a wrong one sends a technician to the wrong house. The Tasks were
designed to be answered at the next customer contact rather than by an outbound
campaign — which is correct, but means they only close when someone rings.

**Action:** these were never going to self-resolve by a date. Either extend them
honestly, or make the six calls. Leaving six overdue high-priority Tasks sitting in
the org is how the 74 unread Duplicate Record Sets happened.

---

# 🟠 Blocked on Marcus

## CF-03 — Licence decision: Salesforce is 4 of 4

**From:** Ticket 1.1, raised 19/08 · **Unanswered for 8 days**

Verified today: **Salesforce 4 of 4 used. Salesforce Platform 1 of 6.**

**This now blocks five things:**

1. Two of the three Monday new hires (never provisioned)
2. Priya's Campaign access — Platform licences have no Campaign object at all
3. Jake having a user account, so he cannot receive his own pipeline report
4. `Marketing Campaign Access` permission set (CF-18)
5. Any resolution of CF-04

**And the cheapest proposed unblock is now known to be unsafe** — see CF-04. Deactivating
or re-licensing Jack and Mia was Week 1's recommendation; both variants damage data
until their pipeline moves.

---

## CF-04 — Who inherits the 666 unowned Opportunities

**From:** Ticket 2.3 · **The top blocker in the org**

| Owner | Opportunities | Open | Open value | Problem |
|---|---|---|---|---|
| OrgFarm EPIC | 224 | 38 | $481,280 | **Deactivated 19/08** |
| Jack Nguyen | 221 | 37 | $466,560 | Never logged in |
| Mia Kelly | 221 | 37 | $473,344 | Never logged in |
| **Total** | **666** | **112** | **$1,421,184** | |

EPIC also holds 13 EmailTemplates and 10 Solutions — **247 records on a disabled user.**

**Both routes out of CF-03 fail until this is done:** deactivating Jack and Mia orphans
442 Opportunities, and moving them to Platform leaves them owning an object their
licence cannot open (`Opportunity` has no `ObjectPermissions` row for Standard Platform
User — identical to the Campaign wall in Ticket 1.3).

**The uncomfortable part:** there is nobody obvious to hand them to. **Hemayet is the
only person who has ever logged into this org.** Ben, Jack, Mia and Priya all show
`LastLoginDate` = never. Ben Carter is the only unencumbered Standard User and he is
one Newcastle rep.

**Asked in [status-note-marcus-ticket-2.3.md](status-note-marcus-ticket-2.3.md). Not yet answered.**

---

## CF-05 — Stale-pipeline threshold: 30 days or 14

**From:** Ticket 2.3

| Threshold | Selects | Value | Where it came from |
|---|---|---|---|
| 30 days past close | 26 | $323,840 | The standing rule as drafted |
| 14 days past close | 42 | $535,424 | The chase-priority cut used in triage |

Both are defensible. **Running both is how numbers start drifting**, which is the
problem Ticket 2.3 exists to fix. One number, then the report, the rule and the Monday
email all align to it.

---

## CF-06 — Confirm Block-on-create

**From:** Ticket 2.2 · **Live in the org right now**

`Account_Duplicate_Rule_Phone` **blocks** on create. A rep entering a genuine new
customer whose phone was mistyped to match an existing record **cannot save.**

That cost lands on Jake's team, not on the admin. It is the right call — an alert
cannot stop a bulk import and a block can, which is how the 2024 mess arrived — but
Marcus owns the trade, not Hemayet. **Reversible to alert in one deploy.**

---

## CF-07 — Roster an owner for the duplicate queue

**From:** Ticket 2.2 · **The control that actually failed in 2024**

The queue is now **empty** — all 74 historical sets were archived and cleared on 26/08,
and all five duplicate rules are verified active, so it will start filling again with
real matches.

**An empty queue with nobody reading it is exactly the 2024 state.** Proposed: Jake,
Mondays, ten minutes. He is already the one who verifies a customer by ringing them.
Hemayet cannot roster Jake.

---

# 🟠 Blocked on Hemayet — these cannot be ghost-written

Seven `✍️ TODO` markers remain across four documents. They are marked *"write this in
your own words"* by design: an SOP in someone else's voice is not yours to defend, and
these are the paragraphs that show understanding rather than button-knowledge.

## CF-08 — Four unwritten sections in the provisioning SOP

**File:** [sop-user-provisioning.md](sop-user-provisioning.md) §1, §3, §4, §7

The document was reversioned **v1.0 → v0.9 DRAFT** on 26/08 so it no longer *claims*
to be finished. It goes back to v1.0 when these are written, not before.

## CF-09 — The freeze-vs-deactivate paragraph

**File:** [sop-user-deactivation.md](sop-user-deactivation.md) §"Freeze vs. deactivate"

**This is the highest-value item in the group.** That SOP went to **v1.1** on 26/08 with
a substantial new owned-records gate — and still carries a blank in the section the
Week 1 brief calls *"the part that shows whether you understand access management or
just know where the buttons are."*

The reasoning now exists in the org's own history — EPIC's 247 orphaned records are the
worked example. The paragraph is easier to write today than it was on the 19th.

## CF-10 — Dormant-user review: the send decision

**File:** [dormant-user-review.md](dormant-user-review.md) — one TODO before sending

Note that the review's premise has changed since it was written: it lists Jack and Mia
as *"retain, monitor at 30 days"* on the basis that they own nothing much. **They own
442 Opportunities between them** (CF-04). The recommendation should be revisited before
it is sent, not just the TODO filled.

## CF-11 — Zara's reply: the three-sentence version

**File:** [ticket-1.3-reply-to-zara.md](ticket-1.3-reply-to-zara.md) — one TODO

A drafted three-sentence version already exists at the foot of the Week 1 brief. The
reply cannot honestly be sent until CF-03 resolves, because **Priya still cannot create
or edit Campaigns** — `UserPermissionsMarketingUser` is `false` and Platform licences
have no Campaign access at all.

---

# 🟡 Ready — actionable, no decision needed

## CF-12 — Jack and Mia have no role

**Verified today:** `UserRole` is null for both. Ben Carter has *Newcastle Sales Team*;
Jack and Mia have nothing, despite both holding a Salesforce licence and the title
*Sales Representative*.

**Consequence:** no role means their records roll up to nobody. Any future
forecast-by-manager, sharing rule or role-based report silently excludes 442
Opportunities.

**Not done unilaterally** because the right role depends on which office they belong to,
and that is a one-line answer from Marcus rather than a guess — but the moment it is
known this is a two-minute change.

## CF-13 — Contact and Lead still run stock rules only

**From:** Ticket 2.2. Account now has three duplicate rules — phone (block), household
name+street (alert), and the stock rule as a safety net. **Contact and Lead have only
the stock fuzzy-name rule.**

Ticket 2.1 merged Contact duplicates too, so the same argument almost certainly applies
and has simply never been made. Worth doing before Week 3 adds more data.

## CF-14 — Week 1 evidence was never captured

**Closed today, partially.** `evidence/week-01/` contained nothing but `.gitkeep`.

The brief required screenshots taken *before* any change: the licence page at 4/4, the
user list, the permission-set assignment screen. Those moments have passed and cannot
be re-photographed.

**What was recoverable has been captured today as data:**

- `evidence/week-01/licence-position.csv` — still shows **Salesforce 4/4**, Platform 1/6
- `evidence/week-01/user-list.csv` — all 11 users with profile, role, last login,
  Marketing User flag and created date

**Stated honestly:** these are today's state, not a pre-change snapshot. They are
evidence of the licence wall being real, which is the claim that mattered — not
evidence of what the org looked like on 19/08.

## CF-15 — The role hierarchy is Salesforce's US sample

18 of the org's roles are the stock Salesforce demo hierarchy and describe no part of
SunRise. Only *Newcastle Sales Team* was purpose-built. A real hierarchy is undesigned,
and CF-12 cannot be answered properly without one.

## CF-16 — Default owner fields all point at the admin

Automated Case User, Default Case Owner, Default Lead Owner, Default Workflow User and
both lead assignment rule entries were all pointed at Hemayet during Ticket 1.1 to clear
EPIC's deactivation blockers. **That was a means to an end, not a design.** Revisit once
queues exist.

---

# 🔵 Deferred — with reasons

## CF-17 — Ben's Manager is a placeholder

Set to the admin because the real reporting line does not exist as users yet. Reassign
when it does. Same is true of Jack, Mia and Priya — **all four report to Hemayet.**

## CF-18 — `Marketing Campaign Access` permission set

**Deliberately not built.** Permission sets are constrained by licence type, so it
would grant Priya nothing while she is on a Platform licence. Building it now would
look like progress and deliver none. **Blocked on CF-03.**

## CF-19 — 47 accounts still violate the naming standard

Still named `… Residence`, grandfathered by the `ISNEW() || ISCHANGED(Name)` guard on
the validation rule so they remain editable.

**Deliberately not renamed yet:** renaming before the merge tail is finished makes the
remaining duplicates *harder* to spot, not easier. Sequence after CF-20.

## CF-20 — Ten middle-initial pairs, held for confirmation

**Due 08/09/2026 · 20 Tasks in the org, all Not Started**

`X` and `X J.` as separate accounts — William Kowalski, Liam Bennett, Lucas Tran,
Michael Young, Ryan Singh, Samuel Fitzgerald, Oliver Murphy, Andrew Anderson, Daniel
Clark, Joshua Patel.

**Held on purpose.** Evidence is strong but circumstantial: 9 of 10 share a suburb,
10 of 10 split landline vs mobile. That is enough to state as the expected answer, not
enough to merge on. Merging them on name similarity plus record age would repeat the
mistake Ticket 2.1 §③/§④ already records.

This is what keeps the customer count a **41–51 range**, and it is the mechanism CF-01's
freeze point depends on.

---

## What Week 3 should not inherit quietly

Three of these have a pattern in common — **CF-02, CF-07 and CF-20 are all controls that
exist and are not being read.** Six overdue Tasks, an empty queue with no reader, twenty
Tasks dated for a fortnight away.

That is precisely the failure Ticket 2.2 diagnosed: *Salesforce flagged the duplicates
in 2024, allowed them, and nobody opened the list.* The tooling built in Week 2 is
better than what existed. **It fails the same way if nobody is rostered to look at it**,
and right now nobody is.
