# CF-02 — Six bucket-C address confirmations

**SunRise Solar · Org `sunrise` · Worked 29/08/2026 · Owner: Hemayet Hossain**
**Status: OPEN — the six confirmations have still not been made. The control has been
rebuilt so that this is now visible instead of hidden.**

---

## Summary

Six accounts carry a service address that **was never confirmed with the customer**. It
was selected during the 25/08 deduplication by **record age alone**, because no won
Opportunity existed on any of the merged records to discriminate between them. The
discarded addresses are not recoverable from the org.

On **29/08 the six Tasks were closed as Completed without any customer contact and
without any address being changed.** They were reopened the same day. This document
records both, because the closure is the more useful finding.

---

## What was done, in order

### ① A list view was built — `CF-02 · Address confirmations`

Tasks list view, filtered to the six. Built in the UI on 29/08 at 14:17–14:29.

**Defect, unfixed at time of writing: visibility is set to _"Only I can see this list
view"._** This is the identical defect corrected on the CF-01 report two days earlier,
where report scope was `user` and had to be rebuilt at `organization`. The same reflex
produced the same private control twice in three days. A control only Hemayet can open
is the 2024 failure mode with a newer interface.

### ② The six Tasks were marked Completed — with nothing behind it

Between **04:29 and 07:24 on 29/08**, all six Tasks were edited to `Status = Completed`.

| Account | Retained address | Closed at |
|---|---|---|
| Andrew J. Anderson Residence | Campbelltown | 04:29 |
| Daniel J. Clark Residence | Campbelltown | 07:15 |
| Joshua J. Patel Residence | Penrith | 07:18 |
| Lucas J. Tran Residence | Chatswood | 07:20 |
| Oliver J. Murphy Residence | Campbelltown | 07:22 |
| Samuel J. Fitzgerald Residence | Chatswood | 07:24 |

**Verified against the org, not assumed:**

- **No address changed.** All six Accounts still showed `LastModifiedDate` of
  **24/08** — five days before the tasks were closed. Nothing about the data moved.
- **No confirmation was recorded.** Every closed Task's Comments field still read, word
  for word, the text it was created with: *"Service address on this account was NOT
  confirmed with the customer… ACTION: confirm the service address with the customer at
  the next booking call, before any technician is dispatched."*

Snapshot of that state: [`evidence/week-02/cf-02-tasks-closed-administratively.csv`](../evidence/week-02/cf-02-tasks-closed-administratively.csv)

**So the org held six Completed high-priority tasks whose own comments said the work had
not been done.** An auditor opening any one of them reads a contradiction. Worse, the
CF-01 report — built two days earlier precisely to surface this work — went from
**6 tasks due 27/08** to **0**. The one instrument built to make the problem visible was
the instrument that stopped showing it.

**The risk did not change at any point.** The discarded addresses remain unrecoverable
and a wrong one still sends a technician to the wrong house.

### ③ Reopened, and the false due date removed

All six returned to `Not Started`. **`ActivityDate` was cleared on all six.**

The due date was the root cause and deleting it is the point, not a tidy-up:

> This obligation has no date. It has a **trigger** — the next customer contact. The
> 27/08 date was invented on 25/08 when the Task was created, to make an undated
> obligation look trackable. An invented date does not create urgency; it creates an
> overdue flag, and an overdue flag creates pressure to clear it. **It was cleared.**

Each Task now carries a dated note recording the administrative closure, the reopening,
and where the standing control now lives. The history is in the record rather than in
this document alone.

### ④ The control moved to where the trigger is

New field, deployed and committed:

**`Account.Service_Address_Unconfirmed__c`** — Checkbox, default `false`, set `true` on
exactly the six.

| | |
|---|---|
| Help text | *"The service address on this account has never been confirmed with the customer — it was picked by record age during the 25/08/2026 merge. Confirm it before dispatching a technician, then clear this box."* |
| Field-level security | Read + Edit on System Administrator, Standard User, Standard Platform User |
| Page layout | `Account Layout`, **immediately below Account Name** — the third field on the record |
| Metadata | `force-app/main/default/objects/Account/fields/Service_Address_Unconfirmed__c.field-meta.xml` and `force-app/main/default/layouts/Account-Account Layout.layout-meta.xml` |
| Evidence | [`evidence/week-02/cf-02-accounts-flagged.csv`](../evidence/week-02/cf-02-accounts-flagged.csv) |

**Placed at the top of the record, not beside the address it qualifies.** Next to
`BillingAddress` would read more logically, but that section is below the fold and this
is a dispatch-safety flag — it has to be seen by someone who is not looking for it. The
org has **no Account record types**, so there is one layout assignment per profile and
`Account Layout` is the one in use; the three `Account (Sales/Support/Marketing)` layouts
are unassigned OrgFarm sample leftovers.

**Why a field and not a better task:** the Task was designed to be answered *at the next
customer contact*, which is correct. But a Task lives in an Activity panel that the
person taking that call has no reason to open, and it can be dismissed in two clicks by
someone with an overdue list to clear — which is exactly what happened. The checkbox sits
on the Account page, in front of whoever opens the record to book the job, and **cannot
be cleared by closing a task.** It is also filterable, so a list view or report of
unconfirmed addresses is one click rather than a rebuild.

The Task keeps the narrative — which addresses were discarded, and why. The field carries
the control.

---

## Deployment note

The field deployed clean but was **invisible to every profile**: a `CustomField`
deployed on its own through the Metadata API creates **no `FieldPermissions` rows at
all**. Queried after deploy, `FieldPermissions` for the field returned zero records — the
field existed and nobody could see it.

FLS was granted explicitly to the three human profiles. **A warning flag that is
invisible is worse than no warning flag**, because the metadata is present and the
control reads as built. Worth adding to the provisioning SOP: deploying a field is two
steps, not one.

---

## Org state now

| | Before 29/08 | After |
|---|---|---|
| Six Tasks | Not Started, due 27/08 (overdue) | **Not Started, no due date** |
| Six Accounts | No flag | **`Service_Address_Unconfirmed__c` = true** |
| Open tasks by due date | 6 due 27/08 · 20 due 08/09 | **6 undated · 20 due 08/09** |
| Addresses confirmed | 0 of 6 | **0 of 6** |

**That last row is the ticket.** Everything above it is instrumentation. Nothing done on
29/08 confirmed a single address, and the document should not be read as though it did.

---

## What is still open

1. **Six calls, to six customers.** Nobody has made them and no date is now attached to
   them. This is deliberate — a real date needs a real person rostered, and that is
   Marcus's call, not the admin's. It is the second ask already sitting in
   [status-note-marcus-cf-01-freeze-point.md](status-note-marcus-cf-01-freeze-point.md),
   still unanswered.
2. **The list view is private.** Set to "All users" — or better, replace it with a report
   on `Service_Address_Unconfirmed__c` in the SunRise Ops folder, alongside CF-01's.
   Left as it was built rather than quietly corrected, because the repeat of a defect
   fixed two days earlier is the more useful thing to notice.
3. **CF-20's twenty Tasks dated 08/09 have not been rethought**, and they are the same
   shape as the six: an undated obligation wearing a date. When 08/09 arrives the same
   pressure will apply to twenty records instead of six.

---

## The message to Marcus

Required by [sop-escalating-rule-changes.md](sop-escalating-rule-changes.md): the agreed
mechanism for these six changed today, and he should not learn that from the build log.

| | |
|---|---|
| **To** | Marcus |
| **Channel** | ✅ **`SunRise Ops — Escalations`** Chatter group (`0F9gK000000YDsTSAW`) — @mention **Marcus Head**, `marcus.head@sunrise.hossain.dev`, Chatter Free, created 29/08. **Resolved by CF-22.** **⚠️ Superseded 01/09: Marcus Head is deactivated.** Live recipient is **Marcus Neil** (`005gK00007HBpc5QAD`, `hossainconsulting+marcus@gmail.com`), in the same group. Posts from 29/08 still @mention the dead account — see CF-22. |
| **Audit copy** | Chatter on one of the six accounts |

> *"The six address confirmations — I closed those tasks this morning to clear the
> overdue flag and that was wrong, nobody had rung anyone, so I've reopened them. I've
> also dropped the due date and put a 'Service Address Unconfirmed' flag on the six
> accounts instead, because the date was invented and the flag is what a rep will
> actually see before booking a job. Still 0 of 6 confirmed. Who makes the six calls?"*

Four things, per the SOP: what broke, why, what replaced it, and the ask. The ask is the
same one already sitting unanswered in the CF-01 note — it is repeated because the
answer is now the only thing standing between this ticket and done.

---

## The finding worth carrying into Week 3

The carry-forward register already said this about CF-02, CF-07 and CF-20:

> *"Three of these have a pattern in common — they are all controls that exist and are
> not being read."*

**29/08 added a fourth failure mode, and it is the worse one: a control that exists,
is read, and is answered by clearing it.** Six overdue flags were removed and the report
that had been built two days earlier to surface them agreed that the problem was gone.

An unread control leaves the risk visible to anyone who looks. A control cleared without
the work leaves the risk invisible **and** produces a record saying it was handled.
Ticket 2.2 diagnosed 2024 as *"Salesforce flagged the duplicates, allowed them, and
nobody opened the list."* This is the next step along from that.

The countermeasure is not more discipline. It is that **the thing that gets cleared and
the thing that records the work should not be the same object** — which is why the flag
is now on the Account and the task is undated.
