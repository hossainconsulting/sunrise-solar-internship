# Dormant user review — SunRise Solar

**Prepared by:** Hemayet Hossain · **Date:** 19/08/2026 · **For:** Marcus
**Source:** `User` and `LoginHistory` queried directly against the `sunrise` org,
19/08/2026. Not a Setup screenshot — the underlying records.

---

## The short version

Marcus asked for anyone dormant 90+ days. **The org is 8 days old, so nobody
qualifies** — and that question, answered literally, produces an empty report.

The useful signal here is not a *stale* Last Login. It's a **blank** one. Two
users have never logged in and are holding **2 of our 4 Salesforce licences** —
which is the same constraint that blocked the Monday new-hire provisioning in
Ticket 1.1. **These two are the answer to the licence decision I escalated.**

---

## Salesforce licences — who holds what

Salesforce: **4 of 4 used, 0 remaining.** Salesforce Platform: **0 of 6 used.**

| User | Profile | Last login | Holding a Salesforce licence? | Recommendation |
|---|---|---|---|---|
| Hemayet Hossain | System Administrator | 19/08 (today) | Yes | **Retain.** Sole admin. |
| Ben Carter | Standard User | Never | Yes | **Retain.** Provisioned 18/08, starts Monday. **Review 24/08** — if he hasn't logged in by end of his first week, that's an onboarding failure, not a licence question. |
| Jack Nguyen | Standard User | Never (created 17/08) | Yes | **Review — decision needed from you.** Never logged in. If Jack is not actively using Salesforce, downgrading him to a Platform licence (0 of 6 used) frees a Salesforce licence at no cost. |
| Mia Kelly | Standard User | Never (created 17/08) | Yes | **Review — decision needed from you.** As above. |

**Recommendation to Marcus:** before we buy licences for the two remaining new
hires, confirm whether Jack and Mia need full Salesforce licences. If either is
read-mostly or works outside standard CRM objects, a Platform licence covers them
and we have 6 sitting unused. That is two hires provisioned on Monday for £0.

If both genuinely need Salesforce licences, then it's a purchase — but we should
know which it is before Friday, not on Monday morning.

## Accounts that are not people — retain, do not touch

| User | Type | Why it exists |
|---|---|---|
| Automated Process | AutomatedProcess | Platform-owned. Executes automation. |
| System (`automatedcase@…`) | AutomatedProcess | **Created 18/08 15:11** — this appeared when Automated Case User was reassigned during the Ticket 1.1 deactivation. Expected, not an intruder. Noted so nobody flags it later as an unexplained account. |
| Platform Integration User | CloudIntegrationUser | Platform-owned. |
| Data.com Clean | AutomatedProcess | Platform-owned. |
| Chatter Expert | CsnOnly | Chatter Free licence, costs nothing. |
| Integration User | Standard (Analytics Cloud Integration) | Analytics licence, not a Salesforce one. |
| Security User | Standard (Analytics Cloud Security) | Analytics licence, not a Salesforce one. |

None of these consume a Salesforce licence. Deactivating them breaks platform
features and recovers nothing.

## Already actioned

| User | Status | Note |
|---|---|---|
| OrgFarm EPIC | **Deactivated 19/08** | See [ticket-1.1-licence-recovery.md](ticket-1.1-licence-recovery.md). Three automated logins via `orgfarm_app_1`, no interactive human session. |

## Method, so this can be re-run

```sql
-- Who is holding what, and when did they last actually log in
SELECT Name, Username, Profile.Name, UserType, IsActive, LastLoginDate, CreatedDate
FROM User ORDER BY IsActive DESC, LastLoginDate DESC NULLS LAST

-- Licence position
SELECT Name, TotalLicenses, UsedLicenses FROM UserLicense WHERE TotalLicenses > 0

-- Blank LastLoginDate is a summary field; LoginHistory is the evidence
SELECT LoginTime, UserId, Application, Status, SourceIp
FROM LoginHistory ORDER BY LoginTime DESC
```

`LastLoginDate` on the User record is a convenience field. When a deactivation or
an audit is on the line, read `LoginHistory` — it shows *how* they logged in
(Browser vs. CLI vs. a provisioning app), which is usually the question that
actually matters.

> ✍️ **TODO before sending:** decide whether you're comfortable putting the
> Jack/Mia downgrade recommendation to Marcus this directly. You've been here
> three days and you're proposing changing two colleagues' licences. The
> recommendation is sound; make sure the framing is a question, not a decision
> you've already made.
