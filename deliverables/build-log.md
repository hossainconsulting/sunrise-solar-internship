# Build log — SunRise Solar Solutions Internship

Every change, with the reason and the requirement it traces to. This is the
artefact that survives the project and the one an auditor or a successor reads.

| Date | Component | Type | Change | Why / requirement |
|---|---|---|---|---|
| 19/08/2026 | Company Information | Audit | Recorded licence position before any change: Salesforce 4 of 4 used, 0 remaining | Ticket 1.1 pre-flight. Established the constraint that shaped every decision below |
| 19/08/2026 | User: OrgFarm EPIC | Deactivation | Deactivated the org provisioning account | Never logged in by a human, consuming 1 of 4 Salesforce licences. Freed a licence for a real new hire. Full write-up: [ticket-1.1-licence-recovery.md](ticket-1.1-licence-recovery.md) |
| 19/08/2026 | Support Settings | Reassignment | Automated Case User: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC |
| 19/08/2026 | Support Settings | Reassignment | Default Case Owner: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC |
| 19/08/2026 | Case assignment rules (Standard, 5 entries) | Reassignment | All Assign To / Notify references: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC. Inactive rules block too |
| 19/08/2026 | Lead assignment rules (Standard, 2 entries) | Reassignment | All Assign To / Notify references: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC |
| 19/08/2026 | Case escalation rules (8 entries + actions) | Reassignment | Every escalation action row's Assign To / Notify: OrgFarm EPIC → H. Hossain | Blocked deactivation of EPIC. The action rows, not the rule headers, held the references |
| 19/08/2026 | Web-to-Lead configuration | Deletion | Removed unused Web-to-Lead config referencing OrgFarm EPIC | Residual blocker after the full rule audit. Training artifact, no live lead capture. In production the config would be exported before deletion — accepted risk, noted |
| 19/08/2026 | Standard case escalation rule | Deletion | Removed unused Standard escalation rule | Residual blocker. Training artifact, no live case flow. Same accepted risk as above. ⚠️ Confirm against the org whether this and the Web-to-Lead deletion were both done, or whether one supersedes the other in my notes |
| 19/08/2026 | Lead Settings | Reassignment | Default Lead Owner: OrgFarm EPIC → H. Hossain | Final blocker before deactivation succeeded |
| 19/08/2026 | Company Information | Verification | Salesforce licences now Used 3 of 4, Remaining 1 | Confirms the licence was actually recovered, not just the user deactivated |
| 19/08/2026 | User: Ben Carter | Creation | Newcastle sales rep. Standard User profile, role set, Manager field set, Australia/Sydney, en_AU, built from scratch (not cloned) | Ticket 1.1. Consumed the recovered licence. ⚠️ Confirm and record the Login As verification result before closing the ticket |
| 19/08/2026 | Deliverable | Documentation | Wrote [sop-user-provisioning.md](sop-user-provisioning.md) v1.0 | Ticket 1.1 deliverable. Licence pre-flight is step 1 because of what happened today |
| 19/08/2026 | Escalation | Communication | Status note to Marcus: 1 of 3 new hires provisioned, at licence capacity, purchase-vs-deactivate decision requested | 2 of 3 hires cannot be provisioned without a licence decision. See [status-note-marcus-ticket-1.1.md](status-note-marcus-ticket-1.1.md) |
