# Week 2 — Data quality and the accounts that aren't real

**Org:** `sunrise` · **~6–8 hours** · **3 tickets** · **3 deliverables**

Week 1 was about people. Week 2 is about the data those people are supposed to
trust, and it opens with a number that should stop you: the org holds **301
Accounts**. It has **61 customers**.

Nothing this week is hard to click. The difficulty is entirely in deciding *which
record survives*, and being able to defend that decision to someone whose
commission depends on it.

**Before you build anything, write your clarifying questions down.** Then compare
them to the ones listed here.

---

## Carried forward from Week 1

Do not start Week 2 pretending these closed:

- **The licence decision is still unanswered**, and it now blocks three things:
  two of the three Monday new hires, and Priya's Campaign access. Salesforce is
  4 of 4. If Marcus hasn't replied by Tuesday, chase him — a request that goes
  quiet is still yours.
- **Seven `TODO` markers** remain across the three SOPs. `sop-user-provisioning.md`
  is versioned v1.0 with blanks in it. Fix the version or fill the blanks.
- **Jack Nguyen and Mia Kelly still have no role**, have never logged in, and hold
  2 of the 4 Salesforce licences.

---

## Ticket 2.1 — "How many customers do we actually have?"

> **Marcus, Monday, standing at your desk**
>
> "Board pack's due end of month and Sarah asked me how many customers we've got.
> I said I'd get back to her. I pulled a report, it said 301. Jake reckons it's
> about 60. Someone's wrong and I need to know who before I put a number in front
> of the board. Can you have a look?"

### What's actually in there

Verified against the org, 21/08/2026:

| | |
|---|---|
| Account records | **301** |
| Distinct names, case-insensitive | **61** |
| Duplicate groups | **60** |
| Records sitting inside those groups | **300** |
| Opportunities attached to them | **890** |

So Jake is right and the report is right. They're answering different questions.

### It is worse than "delete the copies"

Look at one group:

```
"Amelia Martin"            phone (02) 5653 2767   Wollongong
"Amelia Martin"            phone (02) 4493 1527   Wollongong
"Amelia Martin"            phone (02) 6813 4007   Wollongong
"Amelia Martin"            phone (02) 4493 1527   Wollongong
```

Four records, three different phone numbers, one number appearing twice. Now the
group next to it:

```
"Amelia Martin Residence"  phone (02) 4493 1527   Wollongong
"Amelia Martin Residence"  phone (02) 5653 2767   Wollongong
...
```

**Same customer. Different naming convention. Exact-match dedupe will never join
them**, because `Amelia Martin` ≠ `Amelia Martin Residence`. Your 60 groups are
therefore an *undercount* of the real problem.

And then this one:

```
"Andrew Anderson Residence"   Penrith
"Andrew Anderson Residence"   Campbelltown
"Andrew Anderson Residence"   Campbelltown
"Andrew Anderson Residence"   Chatswood
```

Three different suburbs. One of these is where the panels actually are. Merging
blind picks a winner at random and sends a technician to the wrong house.

### Ask before you build

1. What makes two Accounts the same customer here — name, phone, address, or the
   NMI/meter number we don't have a field for?
2. Is `X` and `X Residence` one customer or two? _(Someone decided this once. Find out who.)_
3. When two records disagree on address, which wins — oldest, newest, or the one
   with the most recent Opportunity?
4. Who signs off before I merge anything? Merges are **not reversible**.
5. Do the 890 Opportunities need to survive the merge, and what happens to their
   owners?

Question 4 is the one that saves you.

### The trap

Merging first and asking later. Account merge in Salesforce is permanent — there
is no Recycle Bin for the losing record's field values, and re-creating them from
a report you took afterwards is not the same thing. **Export before you touch
anything.**

The second trap is subtler: merging on name alone will quietly join two genuinely
different customers who happen to share a name. In a 301-record org you can eyeball
that. In a real one you cannot, which is why the rule matters more than the merge.

### Build

1. **Export first.** All 301 Accounts with every field you might need to
   reconstruct — Id, Name, Phone, all Billing fields, `Service_Region__c`,
   OwnerId, CreatedDate. Into `evidence/week-02/`. This is your undo.
2. Produce the **duplicate inventory**: every group, how many records, what
   differs within it, and your proposed surviving record with the reason.
3. Merge only the groups where the surviving record is unambiguous. Leave the
   conflicting-address ones for Ticket 2.2's rule work and a question to Jake.

### Deliverable — Data Quality Audit

One document, in `deliverables/`. It must contain:

- The real customer count, and why the 301 figure exists
- The two *kinds* of duplication you found, with an example of each
- A merge decision rule stated in one sentence that a non-admin could apply
- What you merged, what you deliberately did not, and why
- The rollback position: where the export lives and what it would restore

The number Marcus takes to the board is one line of this document. The other
pages are why he can defend it.

---

## Ticket 2.2 — Stop it happening again

> **Marcus, Slack, Wednesday**
>
> "Good work on the account thing. Obvious question though — how did we end up
> with five of everything? And what stops it happening again next month?"

### The uncomfortable answer

Duplicate management is **already switched on**. Verified in the org:

```
Standard_Account_Duplicate_Rule   Account   Active
Standard_Contact_Duplicate_Rule   Contact   Active
Standard_Lead_Duplicate_Rule      Lead      Active
```

There are **74 Duplicate Record Sets** already sitting in the org — Salesforce
noticed. It flagged, it allowed, nobody looked.

So "turn on duplicate rules" is not the answer. The rules ran. The questions are:

- Are they set to **Allow** with an alert, or **Block**?
- What matching rule are they using, and would it have caught
  `Amelia Martin` vs `Amelia Martin Residence`? _(It would not.)_
- Who was supposed to be reading the alerts?

### Ask before you build

1. Block or Allow-with-alert? _(Block stops bad data and stops a rep mid-sale. There is a real cost either way.)_
2. Do we want a **custom matching rule** on Phone or Billing Street, rather than the standard fuzzy-name rule?
3. Does the same rule apply to records created by the web form, by import, and by hand?
4. What is the naming standard for a residential account — with or without "Residence"?

Question 4 is the actual fix. Rules enforce a standard; they cannot invent one.

### The trap

Building a beautiful matching rule and never writing down the naming standard it
depends on. Six months later someone imports a list with a different convention
and the rule silently stops matching — exactly what happened here.

### Build

- Review the three standard rules; document what they currently do
- Design a matching rule that would have caught **both** kinds of duplicate you
  found in 2.1
- Decide Block vs Allow, and write the justification
- Write the naming standard down somewhere a non-admin will find it

### Deliverable — Duplicate Management Design

Include a **before/after test**: insert a deliberate duplicate, show it was
allowed before and blocked after. `seed/diagnose-duplicate-rule.apex` already does
the insert — extend it rather than starting over.

---

## Ticket 2.3 — The pipeline that lies

> **Jake, email, Thursday**
>
> Subject: forecast
>
> "Hemayet — Marcus wants a forecast number off me by Friday and I don't trust
> what's in Salesforce. There's stuff in there from months ago that's definitely
> dead. Can you tell me what's real? — Jake"

### What's there

**51 open Opportunities have a Close Date in the past.** They are, by definition,
either closed and nobody said so, or slipped and nobody re-dated them. Either way
they are in the forecast right now.

Also worth noting while you're in the data: **38 Accounts have no Phone**, and
`Service_Region__c` splits Sydney 174 / Newcastle 70 / Wollongong 56, with **one
Account blank**. That blank one will break a regional report later.

### Ask before you build

1. Past close date — is that automatically dead, or does Jake genuinely still work some of them?
2. Who is allowed to change a Close Date, and does moving one need a reason?
3. Should this be a report Jake runs himself weekly, or something that nags automatically?

Question 3 decides whether you are solving this once or forever.

### The trap

Mass-closing 51 Opportunities because they look stale. Some of them are real deals
with a lazy owner, and closing them loses the pipeline *and* the relationship
history. This is a report and a conversation before it is an update.

### Deliverable — Pipeline hygiene report

A list is not the deliverable. **Per Opportunity: close, re-date, or ask the
owner** — and a one-line rule that would let Jake do this himself next quarter.

---

## Verify everything

- [ ] The Account count Marcus reports matches the number in your audit
- [ ] Every merge you performed is reconstructable from the export
- [ ] A deliberate duplicate insert is now blocked (or alerted, if that's the decision)
- [ ] No Opportunity was closed without a recorded reason
- [ ] `Service_Region__c` is populated on all 301 — or 61 — Accounts

## Evidence

Screenshot **before you merge anything**: the Account list showing 301, the
duplicate rule settings as they are now, and the Duplicate Record Sets count.
Into `evidence/week-02/`.

Export the full Account table to CSV before the first merge. That file is the
single most important artefact of this week.

Log every change in `build-log.md`, including merges, with the surviving record Id
and the reason it won.

---

## Ask Claude to play Marcus

When the audit is drafted:

> _"Play Marcus. I'm about to tell the board we have 61 customers instead of 301.
> Pull that apart — what would Sarah ask me that I can't answer?"_

And for 2.3:

> _"Play Jake. I'm proposing to close 51 of your opportunities. React the way a
> sales manager on a quota actually would."_
