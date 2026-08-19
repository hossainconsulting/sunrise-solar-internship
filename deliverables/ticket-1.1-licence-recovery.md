# Ticket 1.1 — Licence recovery: deactivating OrgFarm EPIC

**Date:** 19/08/2026 · **Org:** SunRise Solar (`sunrise`) · **Admin:** Hemayet Hossain

**Objective:** free one Salesforce licence for new-hire provisioning by deactivating
the unused OrgFarm EPIC provisioning account.

**Status:** complete. All actions below re-verified against the org on 19/08/2026.

---

## Justification

- OrgFarm EPIC is Salesforce's org-provisioning account, consuming 1 of 4
  Salesforce licences.
- Three new hires start Monday. The org was at 4/4 licence capacity — verified in
  `Setup → Company Information` **before** any change was made.
- The account has **three successful logins** — 11/08 16:54, 15/08 11:00 and 18/08
  11:05 — all via the `orgfarm_app_1` application from AWS addresses
  (52.1.139.45, 54.146.115.54). None by a person, none through a browser. The
  defensible claim is **"no interactive human login; automated provisioning access
  only"** — not "never logged in".
- Deactivating an unused system account is reversible and destroys no data.
  Purchasing licences is neither cheap nor achievable before Monday. It was the
  right first move, and the residual decision (2 hires still unprovisioned) was
  escalated rather than improvised around.

> **On the wording.** The original write-up claimed the account had never been
> logged into. `LoginHistory` says otherwise, and one of those logins landed the
> same day the deactivation was performed. The decision was still correct; the
> claim was not. An auditor pulls `LoginHistory` before they ask you anything.

## Actions taken, in order

Salesforce reports deactivation blockers **one at a time**. Each new error message
meant the previous reference had been cleared successfully.

| # | Blocker reported | Resolution | Re-verified 19/08 |
|---|---|---|---|
| 1 | User is the Automated Case User | `Support Settings` → reassigned Automated Case User to H. Hossain | ✅ `CaseSettings.defaultCaseUser` = H. Hossain |
| 2 | User is the Default Case Owner | `Support Settings` → reassigned Default Case Owner to H. Hossain | ✅ `CaseSettings.defaultCaseOwner` = H. Hossain |
| 3 | User receiving cases/notifications via assignment or escalation rules | Audited the Standard case assignment rule (5 entries), the Standard lead assignment rule (2 entries), and all 8 case escalation rule entries including their action rows. **The lead assignment rule was reassigned. The case assignment rule and the case escalation rule were deleted outright** — see the note below | ✅ Lead rule present and active, both entries → H. Hossain. ✅ No case assignment rules exist. ✅ No case escalation rules exist |
| 4 | Blocker persisted after the rule work | Deleted the unused Web-to-Lead configuration referencing EPIC (training artifact, no live lead capture) | ✅ Default Lead Creator = H. Hossain |
| 5 | User is the Default Lead Owner | `Lead Settings` → reassigned Default Lead Owner to H. Hossain | ✅ Confirmed in Setup |
| — | (also swept) | `Process Automation Settings` → Default Workflow User reassigned to H. Hossain | ✅ Confirmed in Setup |
| 6 | — no further blockers | Deactivated OrgFarm EPIC successfully | ✅ `IsActive = false` |

### On the two deleted Case rules

The earlier draft of this document said all rule references were *reassigned*. The
org shows the Case assignment rule and the Case escalation rule are **gone
entirely** — they were deleted to clear the blocker, not edited.

That is a bigger action than "reassigned" implies, and it is recorded plainly
because the difference matters to whoever picks this org up next:

- Nothing was using either rule. There is no live case routing in this org and no
  case flow to break.
- **In production this would have been the wrong first move.** The correct order is
  reassign the references; if a rule genuinely has to go, export the definition
  first so it can be rebuilt.
- Accepted risk in a training org, logged rather than left to be discovered.

## Verification

`Setup → Company Information → User Licenses` → Salesforce: **Used 3 of 4,
Remaining 1** immediately after deactivation. The licence was genuinely recovered,
not merely a user switched off.

**Current state (re-verified 19/08):** Salesforce is back to **4 of 4 used** — Ben
Carter consumed the recovered licence, as intended. There is no slack left.
Salesforce Platform is **0 of 6 used**, which is where Alan, Lisa and Priya go in
Tickets 1.2 and 1.3, and which is the option the escalation to Marcus now puts on
the table for Jack and Mia.

## The user that was created

**Ben Carter** — Newcastle sales rep, Standard User profile, built from scratch
rather than cloned, Australia/Sydney, en_AU.

He was initially created **without a Role, Manager or Title** — in breach of the
provisioning SOP written the same day. Corrected 19/08:

- **Role:** `Newcastle Sales Team`, a new role created under `Director, Direct
  Sales` so his records roll up alongside the existing Eastern and Western Sales
  Team roles.
- **Manager:** H. Hossain — a **placeholder**, matching Jack and Mia. Marcus, Jake
  and the Newcastle team lead do not exist as users in this org.
- **Title:** Sales Representative.

Verified via Login As (which required enabling "Administrators Can Log in as Any
User" in `Login Access Policies` — it had never been turned on):

- Correct apps visible; can view and create Opportunities.
- **Cannot** create or edit Campaigns — the Standard User profile grants Read only
  on Campaign, and his Marketing User checkbox is unticked. This is the Ticket 1.3
  mechanism, observed directly.
- **Can** open Setup. The Standard User profile has `PermissionsViewSetup = true`
  by default; `ModifyAllData` is false, so it is read-only visibility. This is
  stock Salesforce behaviour rather than a misconfiguration, but it contradicts the
  common assumption that a standard user cannot reach Setup at all. **Raised with
  Marcus as a policy question:** acceptable for sales reps, or strip it?

## Lessons captured (folded into the SOP)

1. System and provisioning accounts commonly hold hidden references. Check these
   **before** attempting deactivation: Support Settings (Automated Case User,
   Default Case Owner), case and lead assignment rules, case escalation rule
   *actions* (every entry, every action row), the Web-to-Lead default record
   creator, Lead Settings (Default Lead Owner), and Process Automation Settings
   (Default Workflow User).
2. Blockers surface one at a time. A new error message is progress, not failure —
   iterate rather than conclude the deactivation is impossible.
3. References held by **inactive** rules still block deactivation.
4. Reassign before you delete. Deleting clears the blocker fastest and costs you
   the configuration; in production, export first.
5. Write down what you *did*, not what you *meant to do*. Three of the entries in
   the first draft of this table said "reassigned" where the org says "deleted".

## Follow-ups

- [ ] Default owner fields now point at the admin. Revisit once queues and roles
      exist and reassign to a queue where that is the correct owner.
- [ ] Ben's Manager is a placeholder — reassign when the real reporting line exists.
- [ ] Jack Nguyen and Mia Kelly have no role. Awaiting their office locations.
- [ ] The role hierarchy is Salesforce's default sample structure; a real SunRise
      hierarchy is undesigned.
- [ ] Decision from Marcus on the two remaining hires — see
      [status-note-marcus-ticket-1.1.md](status-note-marcus-ticket-1.1.md).
