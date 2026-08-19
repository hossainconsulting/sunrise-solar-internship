# Status note to Marcus — Ticket 1.1 (new hire provisioning)

**19/08/2026** · Draft — check the numbers against the org before sending.

---

Marcus — status on the three Monday starters.

**One of three is provisioned.** Ben Carter is set up as a Newcastle sales rep
(Standard User, role and Manager set, built from scratch rather than cloned) and
verified via Login As.

**We were at licence capacity** — 4 of 4 Salesforce licences in use when I started.
I freed one by deactivating OrgFarm EPIC, the provisioning account Salesforce
creates with the org. It has never been logged into by a person and it was holding
a licence. That took clearing six system references it was still attached to; it's
all in the build log with the reasoning.

**The remaining two need a decision from you.** To provision both I need either a
licence purchase, or two more deactivations. Looking at the user list I think
there are candidates for the second option, but that's a call above my pay grade
on day three — and if it's a purchase, it needs starting today to land before
Monday.

Which would you prefer? If neither is possible before Monday, tell me which of the
two hires takes priority and I'll have the other's provisioning record ready to
execute the moment a licence frees up.

— Hemayet

---

### ✍️ Before you send

- Confirm "one of three" is right. The brief's suggested wording says *two* of
  three; you created one user against one recovered licence. Say what actually
  happened.
- Confirm Ben's Login As verification actually ran.
- Either name the deactivation candidates or drop that sentence — Marcus will ask
  "which ones?" and a vague gesture is worse than not raising it.
