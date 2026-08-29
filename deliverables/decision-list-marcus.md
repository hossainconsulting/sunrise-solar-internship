# Eight decisions, numbered — for Marcus

**SunRise Solar · 29/08/2026 · Owner: Hemayet Hossain**
**Everything below is read from the org today. Nothing here needs a meeting.**

---

## Delivery

| | |
|---|---|
| **To** | Marcus Head |
| **Channel** | `SunRise Ops — Escalations` (`0F9gK000000YDsTSAW`) |
| **Audit copy** | This document, committed |

> **He has not logged in yet.** Six posts are waiting for him and none has been read.
> This is the seventh, and it exists because **six prose posts carrying eight decisions —
> two of them bundled two-to-a-post — is not answerable.** He can reply to this one with
> eight short answers.

---

## Why this list exists

Every one of these has a recommendation attached. **None of them is a question in the
air.** If a recommendation is right, the reply is a number and the word "yes". Where
there is no good option I have said so rather than inventing one.

**Four are reversible in minutes. Two are irreversible and I have not touched them.**

---

| # | Decision | My recommendation | Reversible? |
|---|---|---|---|
| 1 | Board-pack customer number | **Take the range, 41–51** | n/a |
| 2 | Who rings the six customers | **Jake — but he has no login (see 3)** | n/a |
| 3 | Licences | **Buy — and it is four, not two** | Yes |
| 4 | Who inherits 666 Opportunities | **Needs a real name. I have none to give you** | Yes |
| 5 | Stale-pipeline threshold | **30 days. One number, not two** | Yes |
| 6 | Block-on-create | **Keep it blocking** | Yes, one deploy |
| 7 | Duplicate-queue reader | **Jake, Mondays, ten minutes** | n/a |
| 8 | Contact merge rule | **Approve as proposed** | **No — 134 records** |

---

## 1 · The board-pack number — CF-01

**41 to 51 households.** Both ends are arithmetic: 51 is the record count today, 41 is 51
minus ten unconfirmed name pairs. The reconciliation back to 301 is in the audit.

I committed on 25/08 to a single number by 27/08. **That date was never supported by the
work set up to deliver it** — the tasks that resolve the ten pairs are dated 08/09.

> **Recommendation: publish the range.** It cannot land outside it, and the rule for when
> it moves is written down. **Or** say the word and I chase ten phone calls this week.

## 2 · Who rings the six customers — CF-02

Six accounts carry a service address chosen by **record age, not evidence**. The
discarded addresses are gone from the org. A wrong one sends a technician to the wrong
house. **0 of 6 confirmed.**

I closed these tasks on 29/08 to clear an overdue flag, with no calls made. That was
wrong and I have reopened them and removed the invented due date.

> **Recommendation: Jake, at the next booking call.** He already verifies customers by
> ringing them. **He has no user account** — so this depends on 3. If 3 is "no", I make
> the six calls myself this week.

## 3 · Licences — CF-03 · *open ten days*

**Salesforce: 4 of 4 used.** Verified again today.

| Who | Needs | Licence required |
|---|---|---|
| Second Newcastle rep | Opportunity | Salesforce |
| Wollongong service tech | Case | Salesforce |
| Priya Sharma | Campaign | Salesforce |
| Jake | a login at all | Salesforce |

**Platform does not help.** A Standard Platform User in this org opens **Account and
Contact and nothing else** — no Opportunity, no Case, no Campaign, no Lead — and we have
no custom objects. That rules it out for the service tech, who needs Cases.

> **Recommendation: buy. And the honest number is four, not two.** Two closes the ticket
> you raised on the 19th; four closes the org. **If the answer is (c) — carry on short —
> say so and I will tell HR, Sarah, Jake and the two hires today.** It is what we are
> doing already; the cost is that nobody outside this thread knows it.

## 4 · Who inherits the 666 Opportunities — CF-04 · *the top blocker*

| Owner | Opps | Open | Open value | Problem |
|---|---|---|---|---|
| OrgFarm EPIC | 224 | 38 | $481,280 | **Deactivated 19/08** |
| Jack Nguyen | 221 | 37 | $466,560 | Never logged in |
| Mia Kelly | 221 | 37 | $473,344 | Never logged in |
| **Total** | **666** | **112** | **$1,421,184** | |

**Nothing else about licences can proceed safely until this is answered.** Deactivating
Jack and Mia orphans 442; moving them to Platform leaves them owning records their
licence cannot open. **I recommended that route in Week 1 and I was wrong** — that is
withdrawn.

> **Recommendation: I do not have one, and that is the finding.** Hemayet is the only
> person who has ever logged into this org. Ben Carter is the only unencumbered Standard
> User and he is one Newcastle rep. **If there is no name today**, say so and I will hold
> them under my own ownership as a declared interim custodian, recorded as such — so they
> are not orphaned while you decide.

## 5 · Stale-pipeline threshold — CF-05

| Threshold | Selects | Value |
|---|---|---|
| **30 days past close** | 26 | $323,840 |
| 14 days past close | 42 | $535,424 |

Both are defensible. **Running both is how numbers start drifting**, which is the problem
Ticket 2.3 exists to fix.

> **Recommendation: 30 days**, as the rule was drafted. I will align the report, the rule
> and the Monday email to it. **Not both.**

## 6 · Block-on-create — CF-06 · *live right now*

`Account_Duplicate_Rule_Phone` **blocks** on create. A rep entering a genuine new customer
whose phone was mistyped to match an existing record **cannot save.** That cost lands on
Jake's team, not on the admin.

> **Recommendation: keep it blocking.** An alert cannot stop a bulk import and a block
> can — which is how the 2024 mess arrived. **But the cost is yours to accept, not mine.**
> Reversible to alert in one deploy.

## 7 · Who reads the duplicate queue — CF-07 · *the control that actually failed in 2024*

The queue is **empty** — all 74 historical sets archived and cleared on 26/08 — and all
five rules are active, so it will start filling with real matches.

**An empty queue with nobody reading it is exactly the 2024 state.**

> **Recommendation: Jake, Mondays, ten minutes.** I cannot roster him, and he cannot log
> in — see 3.

## 8 · The Contact merge rule — CF-13 · *irreversible*

**134 of our 137 Contacts are duplicates.** Ticket 2.1 merged the Accounts and never
touched Contacts.

I tested the obvious rule first this time: *"the record with the most Cases survives"*
**ties in 33 of 37 groups** — the same way the won-Opportunity rule failed in August. It
turns out not to matter: Cases reparent to the survivor automatically, so all 140 are
safe whichever record wins.

| Bucket | Groups | Proposal |
|---|---|---|
| Differ on **phone only** | 16 | **Merge.** Discarded numbers written onto the survivor first |
| Differ on **mailing address** | **21** | **HOLD** |

> **Recommendation: approve as proposed.** The 21 are held because picking an address
> without evidence is exactly how decision 2 came to exist. **Nothing is merged until you
> reply.**

---

## How to answer

Eight lines is enough. *"1 range. 2 Jake. 3 buy four. 4 no name yet, hold them. 5 thirty.
6 keep block. 7 yes Jake. 8 approved."*

**Three of these have been waiting since 25–27 August.** Two of them — 4 and 8 — are
holding real work still.

— Hemayet
