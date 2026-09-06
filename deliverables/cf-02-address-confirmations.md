# CF-02 — Six bucket-C address confirmations

**SunRise Solar · Org `sunrise` · Worked 29/08/2026 · Owner: Hemayet Hossain**

> ## ✅ Corrected 07/09/2026 — this document was two days out of date and wrong on a point of fact
>
> **Status: CLOSED 05/09/2026. All six addresses confirmed with the customer.** Six calls
> were made, all six customers named the suburb already held on the record, no address
> needed changing, and all six `Service_Address_Unconfirmed__c` flags are now correctly
> clear. **Verified in the org 07/09: 0 accounts flagged, 0 open tasks.**
>
> **The body below is left as written on 29/08, with its two false claims struck rather
> than deleted** — this register's practice throughout, because a quietly corrected
> document loses the finding. Two things in it are now known to be wrong:
>
> 1. **"The discarded addresses are not recoverable from the org" — stated twice, and
>    false both times.** They were recoverable from three independent places, all of which
>    existed on the day this was written: the pre-merge CSV
>    (`evidence/week-02/accounts-pre-merge-reconstructed.csv`, a file this very document
>    cites), the recycle-bin rows, and **the tasks themselves** — every one of the six had
>    listed its discarded suburbs in its own 25/08 comment the whole time.
> 2. **"Addresses confirmed: 0 of 6" — now 6 of 6.**
>
> **The first is the more useful error.** It is
> [CF-14](carry-forward-tickets.md#cf-14--week-1-evidence-was-never-captured) a second
> time: a document
> declaring evidence lost while the evidence sits in its own citation list. Both were
> written by the person who had already captured that evidence. **It did not change what
> had to be done** — three candidate suburbs is not an answer, and the calls were still
> the only route — **but it was offered as the reason the calls were the only route, and
> that reason was not true.**
>
> **Recorded honestly, because it matters to how much the result is worth:** all six were
> **prompted**, not open. No customer named their suburb unaided; the three candidates
> were read out and the customer chose. Each task says so in terms. Six prompted
> confirmations of six incumbent values is a real result and a soft one, and the Week 10
> audit will ask.

---

## Summary

Six accounts carry a service address that **was never confirmed with the customer**. It
was selected during the 25/08 deduplication by **record age alone**, because no won
Opportunity existed on any of the merged records to discriminate between them.
~~The discarded addresses are not recoverable from the org.~~ **False — corrected
07/09. They were in the pre-merge CSV, the recycle bin, and on the six tasks
themselves. See the header.**

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

**The risk did not change at any point.** ~~The discarded addresses remain unrecoverable
and~~ **(false — see the header)** a wrong address still sends a technician to the wrong
house. **That risk is now retired: all six were confirmed on 05/09 and all six were
already correct.**

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

| | Before 29/08 | After 29/08 | **Verified 07/09** |
|---|---|---|---|
| Six Tasks | Not Started, due 27/08 (overdue) | **Not Started, no due date** | **Completed, each with an outcome line** |
| Six Accounts | No flag | **`Service_Address_Unconfirmed__c` = true** | **flag clear on all six — correctly** |
| Open tasks by due date | 6 due 27/08 · 20 due 08/09 | **6 undated · 20 due 08/09** | **0 open tasks in the org** |
| Addresses confirmed | 0 of 6 | ~~0 of 6~~ | **6 of 6 (05/09) — all prompted** |
| Addresses changed | — | — | **none. All six were already right** |

**That last-but-one row is the ticket.** Everything above it is instrumentation. Nothing
done on 29/08 confirmed a single address, and the document should not be read as though
it did. **The 05/09 calls are what closed it**, and the column recording that was added
on 07/09 — until then this table still read `0 of 6` two days after the work was done.

---

## What is still open

> **Recounted 07/09. Two of these three are closed; the middle one is not.**

1. ~~**Six calls, to six customers.** Nobody has made them and no date is now attached to
   them. This is deliberate — a real date needs a real person rostered, and that is
   Marcus's call, not the admin's.~~
   ✅ **CLOSED 05/09.** Hemayet made all six himself rather than wait for the roster
   decision. All six confirmed, all prompted, no address changed.
2. 🔴 **The list view is still private — this one is genuinely still open.** `CF-02 ·
   Address confirmations` remains *"Only I can see this list view"*. Set it to "All
   users", or better, replace it with a report on `Service_Address_Unconfirmed__c` in the
   SunRise Ops folder alongside CF-01's.
   **Now nine days unfixed, and its practical urgency has dropped to nil** — the flag is
   clear on all six accounts, so the private view currently shows an empty list. **That is
   exactly why it should be fixed now rather than left**: the next account to be flagged
   will be visible to one person, and nothing will indicate that. A private control is
   cheapest to fix while it is empty and hardest to notice at the same moment.
3. ~~**CF-20's twenty Tasks dated 08/09 have not been rethought**, and they are the same
   shape as the six: an undated obligation wearing a date. When 08/09 arrives the same
   pressure will apply to twenty records instead of six.~~
   ✅ **Overtaken 05/09** — all twenty were answered on the merits three days before the
   date fell, so the pressure this predicted never arrived. **The prediction was sound and
   the outcome does not vindicate the design**: twenty undated obligations wearing a date
   were cleared early by one person working a weekend, not by the control working.
   **Closing note appended to all twenty on 07/09** recording the final count — see below.

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

---

## Addendum 07/09/2026 — the twenty CF-20 tasks asserted evidence their own answers refuted

**Found while closing out CF-02.** All ten CF-20 pairs were answered by 05/09, but every
one of the twenty task records still carried its original 25/08 EVIDENCE paragraph:

> *"EVIDENCE they are one household: matching suburb, and complementary phone formats —
> landline on one record, mobile on the other — consistent with two import sources for the
> same customer. **That pattern holds on all 10 pairs.**"*

**It did hold on all 10 pairs. It predicted the right answer on 3.**

| | |
|---|---|
| Same household | **3** — Kowalski, Bennett, Young |
| Separate households | **7** — Anderson, Clark, Fitzgerald, Murphy, Patel, Singh, Tran |

Eight of the twenty carried a running tally written at the moment they were answered
(`1 for 7`, `2 for 8`, `3 for 9`, `3 for 10`). **Twelve carried none, and not one carried
the final figure.** So twenty closed records stood in the org asserting a hypothesis their
own answers had disproved — readable by an auditor as the basis on which they were closed.

**Fixed 07/09:** a dated closing note appended to all twenty, naming the paragraph it
corrects and giving the final count. **The original paragraph is not deleted** — same
practice as this document's own header. What was believed on 25/08 and what the calls
established are left to be read against each other.

**The finding: a signal present on every member of a set cannot discriminate between
them.** That is the substitution
[ticket-2.1-data-quality-audit.md](ticket-2.1-data-quality-audit.md) §③/§④ already records
as the mistake, arriving a third time.

**And it vindicates the hold.** Had the ten pairs been merged on name similarity plus the
phone pattern — which is what the evidence paragraph was arguing for — **7 of 10 would
have been wrong**, and seven pairs of records for genuinely separate customers would have
been collapsed irreversibly.

**Generated, not hand-edited:**
[build-cf-20-closing-note.py](../scripts/build-cf-20-closing-note.py) derives each pair's
verdict from the task's own answer text in the org rather than from any document,
cross-checks it against the expected split, and refuses to emit on a mismatch, on
surviving non-ASCII, or if the note is already present. **Every defect in these records
since 03/09 entered through hand-editing the Comments box** — the mid-line splits, the
mojibake, the wrong surnames, the doubled alternatives. Twenty records was not a volume to
edit by hand a fifth time.
