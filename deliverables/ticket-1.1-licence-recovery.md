# Ticket 1.1 — Licence recovery: deactivating OrgFarm EPIC

**Date:** 19/08/2026 · **Org:** SunRise Solar (`sunrise`) · **Admin:** Hemayet Hossain

**Objective:** free one Salesforce licence for new-hire provisioning by deactivating
the unused OrgFarm EPIC provisioning account.

---

## Justification

- OrgFarm EPIC is Salesforce's org-provisioning account. No human has ever used it,
  it has no login history, and it was consuming 1 of 4 Salesforce licences.
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
Remaining 1**. The licence is genuinely recovered, not merely a user switched off.

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
