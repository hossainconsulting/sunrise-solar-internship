# Ticket 1.1 — Licence recovery: deactivating OrgFarm EPIC

**Date:** 19/08/2026 · **Org:** SunRise Solar (`sunrise`) · **Admin:** Hemayet Hossain

**Objective:** free one Salesforce licence for new-hire provisioning by deactivating
the unused OrgFarm EPIC provisioning account.

---

## Justification

- OrgFarm EPIC is Salesforce's org-provisioning account, consuming 1 of 4 Salesforce
  licences.
- **Correction (verified 19/08 against `LoginHistory`):** the account is *not*
  loginless. It has three successful logins — 11/08 16:54, 15/08 11:00 and 18/08
  11:05 — all via the `orgfarm_app_1` application from AWS addresses (52.1.139.45,
  54.146.115.54), not a browser, and none by a person. The justification stands, but
  the accurate wording is "no interactive human login; automated provisioning access
  only", not "never logged in". An auditor pulls `LoginHistory` and the original
  claim does not survive contact with it.
- Note the 18/08 11:05 login landed the same day this deactivation was performed,
  which is exactly the kind of detail that reads badly if someone else finds it first.
- Three new hires start Monday. The org was at 4/4 licence capacity — verified in
  `Setup → Company Information` **before** any change was made.
- Deactivating an unused system account is reversible and does not delete data;
  purchasing licences is neither cheap nor available before Monday. It was the
  right first move, and the residual decision (2 hires still unprovisioned) was
  escalated rather than improvised around.

## Actions taken, in order

Salesforce reports deactivation blockers **one at a time**. Each new error message
meant the previous reference had been cleared successfully.

| # | Blocker reported on deactivation attempt | Resolution |
|---|---|---|
| 1 | User is the Automated Case User | `Support Settings` → reassigned Automated Case User to H. Hossain |
| 2 | User is the Default Case Owner | `Support Settings` → reassigned Default Case Owner to H. Hossain |
| 3 | User receiving cases/notifications via case assignment or escalation rules | Audited the Standard case assignment rule (5 entries), the Standard lead assignment rule (2 entries), and all 8 case escalation rule entries **including their action rows** — reassigned every Assign To / Notify reference to H. Hossain |
| 4 | Blocker persisted after the full rule audit | Deleted the unused Web-to-Lead configuration referencing EPIC (training artifact, no live lead capture). Blocker cleared |
| 5 | User is the Default Lead Owner | `Lead Settings` → reassigned Default Lead Owner to H. Hossain |
| 6 | — no further blockers | Deactivated OrgFarm EPIC successfully |

> ⚠️ **Open discrepancy in my notes.** An earlier note records removing an unused
> *Standard case escalation rule* to clear the residual blocker at step 4; the table
> above records deleting the *Web-to-Lead configuration*. Both may have happened.
> Re-check the org and correct this table — a build log that is 90% right is worse
> than one that says which 10% is uncertain.

## Verification

`Setup → Company Information → User Licenses` → Salesforce: **Used 3 of 4,
Remaining 1** immediately after deactivation. The licence is genuinely recovered,
not merely a user switched off.

**Current state (re-verified 19/08 via `UserLicense`):** Salesforce is back to
**4 of 4 used** — Ben Carter consumed the recovered licence, as intended. There is
no slack left. Salesforce Platform is 0 of 6 used, which is where Alan, Lisa and
Priya go in Tickets 1.2 and 1.3.

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
4. In production, export or document any rule or setting before deleting it to
   clear a reference. In this training org the deletion was accepted risk, and it
   is recorded here rather than left to be discovered later.

## Follow-ups

- [ ] Default owner fields now point at the admin. Revisit once queues and roles
      exist and reassign to a queue where that is the correct owner.
- [ ] Resolve the step-4 discrepancy noted above against the org.
- [ ] 2 of 3 new hires remain unprovisioned pending a licence decision — escalated
      to Marcus, see [status-note-marcus-ticket-1.1.md](status-note-marcus-ticket-1.1.md).
