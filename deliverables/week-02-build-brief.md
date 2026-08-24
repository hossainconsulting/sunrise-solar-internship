# Week 2 — Data quality and the accounts that aren't real

**Org:** `sunrise` · **~6–8 hours** · **3 tickets** · **3 deliverables**

Week 1 was about people. Week 2 is about the data those people are supposed to
trust, and it opens with a number that should stop you: the org holds **301
Accounts**. It has **61 customers**.

Nothing this week is hard to click. The difficulty is entirely in deciding _which
record survives_, and being able to defend that decision to someone whose
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

|                                     |         |
| ----------------------------------- | ------- |
| Account records                     | **301** |
| Distinct names, case-insensitive    | **61**  |
| Duplicate groups                    | **60**  |
| Records sitting inside those groups | **300** |
| Opportunities attached to them      | **890** |

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
therefore an _undercount_ of the real problem.

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
- The two _kinds_ of duplication you found, with an example of each
- A merge decision rule stated in one sentence that a non-admin could apply
- What you merged, what you deliberately did not, and why
- The rollback position: where the export lives and what it would restore

The number Marcus takes to the board is one line of this document. The other
pages are why he can defend it.

---

### # Build Guide — Ticket 2.1: The Customer Count

## Phase 0 — Export FIRST (your undo button)

1. ☐ Reports tab → New Report → Accounts → Continue
2. ☐ Filters: Show Me = All accounts · Created Date = All Time
3. ☐ Columns — add: Account ID, Account Name, Phone, Billing Street,
   Billing City, Billing State, Billing Zip, Service_Region\_\_c (if
   present), Account Owner, Created Date
4. ☐ Save & Run → name: "AUDIT All Accounts 21-08-2026"
5. ☐ Export (▼ next to Edit) → Details Only → .xlsx →
   save into evidence/week-02/
6. ☐ Open the file, confirm 301 rows. THIS is your rollback position.

## Phase 1 — Build the duplicate inventory (in the spreadsheet)

7. ☐ In Excel: sort by Phone. Add a column "GroupKey" = the phone
   number. Blank phones → GroupKey = name for now, flag them.
8. ☐ Add column "Group Size" (COUNTIF on GroupKey). Filter Size > 1.
9. ☐ Add columns: "Survivor?" · "Reason" · "Conflicts" · "Action"
   Actions are exactly one of: MERGE-CLEAN / HOLD-CONFLICT / ASK-JAKE
10. ☐ Apply Jake's rules per group:
    - same phone → same customer (even across "X" / "X Residence")
    - survivor = record with most recent WON Opportunity;
      tiebreak: oldest CreatedDate (longest history)
    - name for survivor: the person form ("Amelia Martin"), not
      the site form — note this as a chosen convention
    - any address conflict with no won-Opp winner → HOLD-CONFLICT
    - Andrew Anderson group → ASK-JAKE (he told you so)
11. ☐ Save as "Duplicate Inventory v1" in evidence/week-02/

## Phase 2 — Get sign-off (the step that saves you)

12. ☐ Write the one-sentence rule for Marcus's approval:
    "Two Accounts are the same customer when their phone numbers
    match; the surviving record is the one with the most recent won
    Opportunity, and any group without a clear winner is held for
    review rather than merged."
13. ☐ Record Marcus's approval + Jake's inventory review in the
    build log BEFORE merging. (Role-play: both given above — note it.)

## Phase 3 — Merge the clean groups only

14. ☐ Open the survivor Account record. If a "Potential Duplicates"
    card shows → View Duplicates → tick the copies (max 3 per merge,
    incl. survivor — a 4-record group takes two passes) → Next
15. ☐ Choose the master record = your survivor → then field-by-field,
    pick the value your inventory says wins (phone/address) → Merge
16. ☐ No duplicates card showing? Fallback: App Launcher → search
    "Duplicate Record Sets" — standard duplicate rules populate sets
    you can merge from. Still nothing → tell me, we'll enable a
    matching rule (that's Ticket 2.2 territory anyway).
17. ☐ After each merge: survivor still has its Opportunities?
    Spot-check one group's Opp count before/after in the related list.
18. ☐ Update inventory: Action → MERGED + date. Slow is fine.
    Merges are permanent; the inventory is your audit trail.

## Phase 4 — What you deliberately did NOT do

19. ☐ HOLD-CONFLICT and ASK-JAKE groups: listed in the audit doc
    with the reason. Not merging them IS a decision — document it.

## Phase 5 — The Data Quality Audit (deliverable)

20. ☐ One document, deliverables/. Sections:
    ① The number: "SunRise Solar has ~61 customers; the 301 figure
    counts records, not customers, due to import duplication."
    ② Two kinds of duplication, one example each:
    exact-name copies · naming-convention twins (X / X Residence)
    ③ The merge rule (the Phase 2 sentence, verbatim)
    ④ Merged: N groups / M records. Held: K groups, and why.
    ⑤ Rollback: full pre-merge export in evidence/week-02/,
    restorable fields listed. Plus: all 890 Opportunities
    reparented automatically; owners unchanged.
21. ☐ Line one is Marcus's board number. Pages two onward are why
    he can defend it."

### Personal Note

### 21/08/2026 — Ticket 2.1: merge rule approved

- Rule posted to Chatter with inventory attached (screenshot in evidence/)
- Marcus: approved rule verbatim. Jake: reviewed inventory; Anderson
  group explicitly HELD at his request
- Scope authorised: MERGE-CLEAN groups only (N groups, M records)
- HOLD-CONFLICT and ASK-JAKE groups excluded until resolved
- ASK-JAKE, confirmed by data, not just his warning
  -"Amelia group (8 accounts) merged 24/08 6:44–6:46am via Duplicate Record Set DRS-0000000025, ahead of planned Classic-tool sequence; survivor [ID from URL] matches inventory pick (4493 1527). Contact duplicates merged 7:01am (3 removed). Losers recoverable in Recycle Bin. Verified children intact post-merge."
  -"Anderson merge performed in error against HOLD status; reversed via undelete [7:58am]; child record placement verified."
  -children were concentrated on survivor pre-merge; nothing lost."
  - Duplicate inventory rebuilt 24/08. Grouping key corrected from phone-only to name + address after the original key missed 127 duplicate accounts. Final state: 82 duplicate households identified (276 accounts), 0 merged, 18 clean and ready to merge, 64 requiring review for conflicting phone numbers. Anderson resolves to 3 households across Campbelltown, Penrith and Chatswood; whether the three are one premises with bad suburb data remains open. Survivor selection rule not yet established — neither Created Date nor field completeness discriminates within any household.

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

### # Build Guide — Ticket 2.2: Stop It Happening Again

## Phase 0 — Document the current state (BEFORE changing anything)

1. ☐ Setup → Quick Find "Duplicate Rules" → open each of the three
   standard rules. For each, record: Action on Create (Allow/Block?),
   Action on Edit, Alert shown?, Report on duplicates ticked?,
   which MATCHING rule it uses. Screenshot each → evidence/week-02/
2. ☐ Setup → "Matching Rules" → open Standard Account Matching Rule →
   note its fields (fuzzy name + billing fields). Write one line in
   the build log: "Fuzzy-name matching cannot join 'Amelia Martin'
   with 'Amelia Martin Residence' — this is WHY 2.1 happened."
3. ☐ App Launcher → "Duplicate Record Sets" → screenshot the 74.
   That's Salesforce having flagged everything, unread. The failure
   was process (nobody assigned to read alerts), not technology.

## Phase 1 — Decisions (with justification written down)

4. ☐ Matching: NEW custom matching rule on the field Jake actually
   verifies — Phone, exact match. It catches BOTH 2.1 duplicate
   kinds: exact-name copies AND naming-convention twins share phones.
5. ☐ Action: **Block on Create for manual entry; Allow-with-alert on
   Edit.** Justification: blocking creation stops next month's mess;
   allowing edits avoids trapping reps mid-update on legacy records.
   (Note honestly: Block can interrupt a rep mid-sale — that's the
   accepted cost, and Marcus signs off on it, not you.)
6. ☐ Q3 (web form / import / manual): duplicate rules run on all
   three, BUT bulk API imports can bypass alerts → the SOP rule is
   "imports get deduped against the phone key BEFORE loading."
7. ☐ Q4 — the real fix, the naming standard, one line:
   "Residential accounts are named for the person — 'Amelia Martin',
   never 'Amelia Martin Residence'. Sites live in the address fields."

## Phase 2 — Build it

8. ☐ Setup → Matching Rules → New Rule → Object: Account
   - Name: Account Phone Exact Match
   - Field: Phone · Matching Method: Exact
   - Save → **Activate** (activation takes a minute to index)
9. ☐ Setup → Duplicate Rules → the standard Account rule can't be
   edited while active if you're changing its matching rule →
   simpler: New Rule → Object: Account
   - Name: Account Duplicate Rule — Phone
   - Action on Create: Block · Action on Edit: Allow, with alert
   - Alert text: "Possible duplicate — an account with this phone
     number exists. Check before saving. (Naming standard: person's
     name, no 'Residence'.)" ← the standard, IN the error message,
     where a non-admin will definitely find it
   - Matching Rule: Account Phone Exact Match → Save → Activate
10. ☐ Also put the standard where else people look: Object Manager →
    Account → Name field → Help Text: "Person's name only, e.g.
    'Amelia Martin'. No 'Residence'."

## Phase 3 — The before/after test (deliverable requirement)

11. ☐ BEFORE evidence: you already have it — 2.1's 300 dupes existed
    under the old rules. Cite it.
12. ☐ AFTER: extend seed/diagnose-duplicate-rule.apex — run its
    insert of a deliberate phone-match duplicate → expect a
    DUPLICATES_DETECTED failure → screenshot the error →
    evidence/week-02/. Then try via UI too (New Account, existing
    phone) → blocked with your alert text. Delete any test records.

## Deliverable — Duplicate Management Design (deliverables/)

① What existed and why it failed (fuzzy name + unread alerts)
② The new design: phone matching, Block/Allow split, justification
③ The naming standard, verbatim, and the three places it now lives
(error message, field help, this doc)
④ Before/after test evidence
⑤ Who reads the Duplicate Record Sets from now on, and how often"

- ***

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
with a lazy owner, and closing them loses the pipeline _and_ the relationship
history. This is a report and a conversation before it is an update.

### Deliverable — Pipeline hygiene report

A list is not the deliverable. **Per Opportunity: close, re-date, or ask the
owner** — and a one-line rule that would let Jake do this himself next quarter.

# Build Guide — Ticket 2.3: The Pipeline That Lies

## Phase 0 — See the damage

1. ☐ Reports → New Report → Opportunities
   Filters: Show Me: All · Close Date: All Time ·
   add filter Closed EQUALS False · add filter Close Date LESS THAN TODAY
2. ☐ Columns: Opportunity Name, Account Name, Owner, Stage, Amount,
   Close Date, Last Activity, Created Date
3. ☐ Confirm ~51 rows. Save as "Pipeline Hygiene — Stale Open Opps".
   Export → evidence/week-02/. Screenshot the total $ — that's the
   amount currently lying to Marcus's forecast.

## Phase 1 — Triage, don't touch (the trap is mass-closing)

4. ☐ In the export, add column "Recommendation", one of three:
   - CLOSE — Close Date >90 days past AND no activity 60+ days
     (dead; recommend Closed Lost, reason "stale — unresponsive")
   - RE-DATE — activity within 30 days (real deal, lazy date;
     owner picks the new date, not you)
   - ASK OWNER — everything between
5. ☐ You CHANGE NOTHING yet. The deliverable is recommendations;
   Jake executes on his own pipeline. Admins who close reps' opps
   unilaterally get feelings-based Slack messages.

## Phase 2 — The one-line rule (so Jake self-serves next quarter)

6. ☐ "Any open Opportunity whose Close Date is more than 30 days past
   gets re-dated or closed by its owner within a week, or it is
   closed lost with the reason 'stale'."

## Phase 3 — Solve it forever (Q3)

7. ☐ Now: subscribe Jake to the report — open it → Subscribe →
   weekly, Monday 8am, conditions optional → Jake gets the nag
   automatically. Zero maintenance.
8. ☐ Note for later (Week 5-ish): a Flow that emails owners when
   Close Date slips past — mention it in the doc as the upgrade
   path, don't build it today.

## Phase 4 — The data debris while you're in there

9. ☐ The ONE blank Service_Region**c Account: find it (report,
   filter Service_Region**c EQUALS ""), fix it from its billing
   city, log it.
10. ☐ The 38 phoneless Accounts: DON'T fix today — flag in the
    deliverable as a data-quality backlog item (and note the irony:
    phone is now the dedupe key, so phoneless records are invisible
    to the new rule — that's worth saying to Marcus).

## Deliverable — Pipeline hygiene report (deliverables/)

Per-opp table with the three-way recommendation + the one-line rule

- the subscription set up + the phoneless-accounts caveat.

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
