# Build log — SunRise Solar Solutions Internship

Every change, with the reason and the requirement it traces to. This is the
artefact that survives the project and the one an auditor or a successor reads.

| Date | Component | Type | Change | Why / requirement |
|---|---|---|---|---|
| 19/08/2026 | Company Information | Audit | Recorded licence position before any change: Salesforce 4 of 4 used, 0 remaining | Ticket 1.1 pre-flight. Established the constraint that shaped every decision below |
| 19/08/2026 | User: OrgFarm EPIC | Deactivation | Deactivated the org provisioning account | Consuming 1 of 4 Salesforce licences with no interactive human use. Freed a licence for a real new hire. Full write-up: [ticket-1.1-licence-recovery.md](ticket-1.1-licence-recovery.md) |
| 19/08/2026 | Support Settings | Reassignment | Automated Case User: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC. **Verified 19/08** — `CaseSettings.defaultCaseUser` now resolves to H. Hossain |
| 19/08/2026 | Support Settings | Reassignment | Default Case Owner: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC. **Verified 19/08** — `CaseSettings.defaultCaseOwner` now resolves to H. Hossain |
| 19/08/2026 | Lead assignment rules (Standard, 2 entries) | Reassignment | Both rule entries' Assign To: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC. **Verified 19/08** — rule still present and active, both entries point at H. Hossain |
| 19/08/2026 | Case assignment rules (Standard, 5 entries) | **Deletion** | Rule deleted outright. Audited first, but cleared the blocker by deleting rather than reassigning | Blocked deactivation of EPIC. Training org, no live case routing. **In production this would have been reassignment, or export-then-delete.** Accepted risk, recorded here. Verified 19/08: no case assignment rules exist in the org |
| 19/08/2026 | Case escalation rules (Standard, 8 entries + action rows) | **Deletion** | Rule deleted outright, including its escalation action rows | Blocked deactivation of EPIC — the references sat in the action rows, not the rule header. Training artifact, no live case flow. Same accepted risk as above. Verified 19/08: no case escalation rules exist in the org |
| 19/08/2026 | Web-to-Lead configuration | Deletion | Removed the unused Web-to-Lead config referencing OrgFarm EPIC. Default Lead Creator now H. Hossain | Residual blocker after the rule work. Training artifact, no live lead capture. In production the config would be exported before deletion — accepted risk, noted |
| 19/08/2026 | Lead Settings | Reassignment | Default Lead Owner: OrgFarm EPIC → H. Hossain | Final blocker before deactivation succeeded. Verified 19/08 |
| 19/08/2026 | Process Automation Settings | Reassignment | Default Workflow User → H. Hossain | Part of the same reference sweep. Verified 19/08 |
| 19/08/2026 | Company Information | Verification | Salesforce licences: Used 3 of 4, Remaining 1 | Confirms the licence was actually recovered, not just the user switched off |
| 19/08/2026 | User: OrgFarm EPIC | Correction | Justification reworded: the account has 3 automated logins via `orgfarm_app_1` (11/08, 15/08, 18/08), not zero. "No interactive human login" is the defensible claim; "never logged in" was wrong | Verified against `LoginHistory`. The deactivation decision is unchanged; the written record now survives an audit |
| 19/08/2026 | User: Ben Carter | Creation | Newcastle sales rep. Standard User profile, Australia/Sydney, en_AU, built from scratch (not cloned) | Ticket 1.1. Consumed the recovered licence |
| 19/08/2026 | Role: Newcastle Sales Team | Creation | New role created with parent `Director, Direct Sales` | Ben had no role, in breach of [sop-user-provisioning.md](sop-user-provisioning.md) §2. Placed alongside the existing Eastern/Western Sales Team roles so records roll up the same way. **Note:** the org's other 18 roles are Salesforce's default US sample hierarchy and do not reflect SunRise — a real hierarchy design is outstanding |
| 19/08/2026 | User: Ben Carter | Correction | Role set to Newcastle Sales Team, Manager set to H. Hossain, Title set to Sales Representative | Created without Role, Manager or Title, in breach of the SOP written the same day. Manager set to the admin as a **placeholder** — reassign when the real reporting line exists as users |
| 19/08/2026 | Login Access Policies | Configuration | Enabled "Administrators Can Log in as Any User" | Required to verify new users per [sop-user-provisioning.md](sop-user-provisioning.md) §5. Had never been enabled |
| 19/08/2026 | User: Ben Carter | Verification | Verified via Login As: app access confirmed, can view and create Opportunities, cannot create or edit Campaigns | Ticket 1.1 verification step, now actually performed rather than asserted |
| 19/08/2026 | Profile: Standard User | Finding | Ben **can** open Setup — `PermissionsViewSetup` is true on the Standard User profile by default (read-only; `ModifyAllData` is false) | Discovered during Login As verification. Not a misconfiguration, but it contradicts the assumption that a Standard User cannot reach Setup. **Open question for Marcus:** is read-only Setup visibility acceptable for sales reps, or should it be stripped via profile? |
| 19/08/2026 | Object: Campaign | Verification | Standard User profile grants **Read only** on Campaign — no Create, Edit or Delete. Ben's Marketing User checkbox is unticked | Confirms the Ticket 1.3 premise: Campaign edit is gated by both the object permission and the Marketing User checkbox |
| 19/08/2026 | Company Information | Verification | Salesforce now **4 of 4 used** again (Ben consumed the recovered licence). Salesforce Platform: **0 of 6 used** | Current licence position. No Salesforce slack remains; the 6 idle Platform licences are the unexplored option in the escalation to Marcus |
| 19/08/2026 | Escalation | Communication | Status note to Marcus: 1 of 3 provisioned, licence-type review proposed for Jack and Mia rather than deactivation, decision needed by close of Friday | 2 of 3 hires cannot be provisioned without a licence decision. See [status-note-marcus-ticket-1.1.md](status-note-marcus-ticket-1.1.md) |

## Outstanding

- [ ] Jack Nguyen and Mia Kelly have **no role** assigned. Awaiting confirmation of
      their office before placing them in the hierarchy.
- [ ] Ben's Manager is a placeholder (the admin). Reassign once Marcus, Jake or a
      Newcastle team lead exists as a user.
- [ ] The role hierarchy is Salesforce's default sample structure. A real SunRise
      hierarchy is undesigned.
- [ ] Default owner fields all point at the admin. Revisit once queues exist and
      reassign to a queue where that is the correct owner.
- [ ] Decision from Marcus on the two unprovisioned hires.
