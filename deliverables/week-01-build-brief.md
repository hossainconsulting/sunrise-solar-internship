# Week 1 — Foundation & User Management

**Org:** `sunrise` · **~5–7 hours** · **3 tickets** · **2 SOPs out**

You start Monday. Marcus is your manager. Nothing this week is technically hard —
that's the point. Week 1 tests whether you follow a process or improvise, and
every ticket has a trap that only catches people who skip the questions.

**Before you build anything, write your clarifying questions down.** Then compare
them to the ones listed here. The gap between your list and this one is your
actual study list.

---

## Ticket 1.1 — Three new hires start Monday

> **Marcus, in your first 1:1**
>
> "Right, first task for you. Three new hires starting Monday: two sales reps for
> the Newcastle office, one service tech for Wollongong. HR sent me their details
> on Friday. I need them set up in Salesforce with the right access before 9am
> Monday. The sales reps go into the standard Sales rep profile. The service tech —
> talk to Sarah about what he needs. Any questions? Come and grab me."

### Ask before you build

1. What email domain — is Newcastle on a subdomain?
2. Where do the reps sit in the role hierarchy — under Jake directly, or a Newcastle team lead?
3. For the service tech: mirror an existing tech's access, or is this a new role?
4. Who does each report to? _(Manager field drives approval routing in Week 5.)_
5. Any permission sets beyond the profile — Marketing User, Knowledge User?
6. Is there an existing onboarding SOP, or am I writing one?

Question 6 is the one Marcus is actually waiting for.

### The licence wall — and it's real

Check `Setup → Company Information` before you start. You have **4 Salesforce
licences and all 4 are in use**: OrgFarm EPIC, you, Jack Nguyen, Mia Kelly.

You cannot create three new Salesforce users. This is not a flaw in the exercise —
it is the most common Week 1 reality in a small org, and how you handle it _is_
the deliverable.

**Do this:**

- Deactivate **OrgFarm EPIC** (`Setup → Users → Edit → untick Active`). It's
  Salesforce's provisioning account, it has never logged in, and it's consuming a
  licence. Freeing it is a defensible admin decision — write the justification in
  your build log.
- Create **one** new hire properly against that licence: `Ben Carter`, Newcastle
  sales rep, Standard User, Manager set, Australia/Sydney, en_AU.
- For the other two, write the provisioning record but don't create the users.
  Your status note to Marcus says: _"Two of three provisioned. We're at licence
  capacity — I've freed one by deactivating an unused system account. The third
  and fourth need either a licence purchase or two deactivations. Which would you
  prefer?"_

That message is worth more than three users. It surfaces a constraint before it
becomes a Monday morning failure, and it offers options rather than a problem.

### The trap

Cloning an existing user and hitting Save. The new hire silently inherits stale
permission sets from whoever you cloned — including record access they shouldn't
have. Build from scratch, applying profile and permission sets deliberately.

You will get to prove this in Week 10, when the audit finds it.

### Deliverable — User Provisioning SOP

One page, in `deliverables/`. It must cover:

- **Pre-flight: confirm an available licence of the correct type.** You learned
  this the hard way today. It goes first.
- Licence type → profile → role → Manager field → permission sets, in that order
- The Marketing User checkbox, and that it is _not_ a profile permission
- Why you never clone
- How you verify (Login As)

---

## Ticket 1.2 — Deactivate the leavers

> **Marcus, Slack, Tuesday morning**
>
> "Hemayet — HR just told me two people left last month and their Salesforce
> licences are still active. Alan Brooks and Lisa Fernandez. Can you deactivate
> them? While you're at it, run a login history check — anyone who hasn't logged
> in for 90+ days should probably be reviewed. Ta."

### Setup first

Alan and Lisa don't exist in your org yet. Create them as **Salesforce Platform**
users (you have 6 free), then transfer them some records so the exercise is real:

```
Alan Brooks    alan.brooks@sunrise.hossain.dev    Standard Platform User
Lisa Fernandez lisa.fernandez@sunrise.hossain.dev Standard Platform User
```

Then reassign ~20 Accounts to each: `Setup → Mass Transfer Records → Transfer
Accounts`. Now they own something and deactivation has consequences.

### Ask before you build

1. What do Alan and Lisa own — Accounts, Opportunities, Cases? Where does it go?
2. Are either mid-approval on anything?
3. Are they in Default Account or Opportunity Teams?
4. Do we have a Freeze-before-Deactivate process? _(Freeze locks login without
   releasing the licence — the right move during a contested exit while legal
   decides.)_
5. For the 90-day dormant users — deactivate, or produce a report for you and
   Marcus to review?

### Find what they own — faster than clicking

`Developer Console → Debug → Open Execute Anonymous Window`:

```apex
Id u = [SELECT Id FROM User WHERE Name = 'Alan Brooks' LIMIT 1].Id;
System.debug('Accounts:      ' + [SELECT COUNT() FROM Account     WHERE OwnerId = :u]);
System.debug('Opportunities: ' + [SELECT COUNT() FROM Opportunity WHERE OwnerId = :u]);
System.debug('Cases:         ' + [SELECT COUNT() FROM Case        WHERE OwnerId = :u]);
System.debug('Open Leads:    ' + [SELECT COUNT() FROM Lead        WHERE OwnerId = :u AND IsConverted = false]);
```

### The trap

Deactivating someone who owns records without transferring first. Reports break,
and the records are orphaned in a way that is tedious to unpick. **Transfer, then
freeze, then deactivate** — in that order.

### On the dormant-user report

Your org has no 90-day login history — it's days old. But it has users who have
**never logged in**, and a blank Last Login is arguably a stronger signal than a
stale one. Build the report from `Setup → Users` with the Last Login column.

The list is not the deliverable. **The recommendation column is** — per user:
revoke, retain with justification, or review by a date. A list tells Marcus
nothing he couldn't get himself.

### Deliverable — User Deactivation SOP

Checklist format. Must include the Freeze-vs-Deactivate distinction and _why_ —
that one paragraph is what makes it read as written by a professional.

"# Build Guide — Ticket 1.2: Deactivate the Leavers

## Phase 0 — Setup (make the exercise real)

1. ☐ Create the two "leavers" — Setup → Users → New User, from scratch:
   - Alan Brooks · alan.brooks@sunrise.hossain.dev
   - Lisa Fernandez · lisa.fernandez@sunrise.hossain.dev
   - Licence: **Salesforce Platform** (you have 6 free — does NOT touch
     your precious 1 remaining Salesforce licence)
   - Profile: **Standard Platform User** · Sydney / en_AU / AUD
   - Untick the password email
2. ☐ Give them records to own: Setup → **Mass Transfer Records** →
   Transfer Accounts → transfer ~20 Accounts from yourself to Alan,
   ~20 to Lisa. (If the org lacks 40+ accounts, split what exists —
   the point is that they own _something_.)

## Phase 1 — Ask Marcus (the graded part)

3. ☐ Send the five questions from the ticket. Play out his answers
   (or ask me to be Marcus again). Do NOT build past this without
   answers to Q1 (where records go) and Q4 (freeze process) — they
   change the steps below.

## Phase 2 — Discover what they own

4. ☐ Developer Console (gear icon → Developer Console) → Debug →
   **Open Execute Anonymous Window** → paste the ticket's Apex →
   Execute → tick "Open Log" → Debug Only filter → read the counts.
5. ☐ Run it twice: once for 'Alan Brooks', once for 'Lisa Fernandez'.
6. ☐ Record the counts in your build log. (This is your first real
   SOQL — four queries doing what forty clicks would.)

## Phase 3 — Transfer → Freeze → Deactivate (order is the lesson)

Per leaver: 7. ☐ TRANSFER: Setup → Mass Transfer Records → Transfer Accounts →
from Alan/Lisa → to the destination Marcus named (likely you or
Jake). Re-run the Apex to confirm all counts = 0. 8. ☐ FREEZE: Setup → Users → click their name → **Freeze** button.
Login now locked; licence still consumed. In real life this is
the instant-response step the moment someone exits. 9. ☐ DEACTIVATE: Users → Edit → untick Active → Save.
(If blocked by references — you know this dance better than
anyone in the southern hemisphere. §6 of your SOP.) 10. ☐ Verify: both inactive; Salesforce Platform licences back to 6
remaining; spot-check a transferred Account's owner.

## Phase 4 — Dormant user review

11. ☐ Setup → Users → view "All Users" → note the **Last Login**
    column. Blank = never logged in.
12. ☐ Build the deliverable as a table (spreadsheet or markdown) —
    one row per user, and the column that matters: **Recommendation**.
    Realistic calls for this org:
    - Never-logged-in humans (Mia, Jack, Ben) → _retain: provisioned
      for active staff, monitor at 30 days_
    - Integration/system users → _retain with justification: service
      accounts, exclude from login-based review_
    - Chatter Expert → _review: candidate for deactivation, unused_
13. ☐ One-paragraph summary on top for Marcus: what you'd revoke
    today, what needs his call.

## Phase 5 — Deliverable: User Deactivation SOP

14. ☐ Checklist format, deliverables/ folder. Skeleton:
    a. Trigger: HR notification of exit (same-day action)
    b. IMMEDIATELY: Freeze (locks access, keeps licence)
    c. Discover owned records (the SOQL block — include it in the SOP)
    d. Confirm destination with manager; Mass Transfer
    e. Check: approval processes in flight, Account/Opp team
    memberships, system references (link SOP §6 from Ticket 1.1)
    f. Deactivate; verify licence released
    g. Log: date, actor, record counts moved, destination
    h. **Freeze vs Deactivate paragraph** — write it yourself; the
    ticket says this is what marks it professional. Core idea:
    freeze is instant lockout that preserves everything (right for
    contested exits, legal holds, same-hour security response);
    deactivate is the tidy end-state that frees the licence but
    demands the record work first. Freeze buys time safely.

## Definition of done

☐ Alan & Lisa: created → owned records → transferred (verified 0) →
frozen → deactivated
☐ Dormant report with per-user recommendations + summary paragraph
☐ Deactivation SOP incl. freeze-vs-deactivate rationale
☐ Build log updated."

---

## Ticket 1.3 — Campaign access for a new marketing coordinator

> **Zara, email, Wednesday**
>
> Subject: Campaign access
>
> "Hi Hemayet — welcome to SunRise! I heard we finally have an admin again 🎉
> Quick request — I hired a new marketing coordinator (Priya Sharma, starts next
> Monday) and she needs to be able to create and edit Campaigns. Alex used to just
> do this but I've never known exactly how. Can you sort it? — Zara"

### You already know the answer

You hit this in Phase 0, when a System Administrator couldn't delete four sample
campaigns:

```
DML operation Delete not allowed on Campaign
```

Campaign create, edit and delete are gated by the **Marketing User checkbox on
the User record** — not by the profile, and it's off by default even for admins.
Object permissions say yes; the checkbox says no; the checkbox wins.

### Ask before you build

1. Is Priya on Marketing's headcount, or shared with Sales?
2. All Campaigns, or only ones she owns? _(OWD implications.)_
3. Marketing User checkbox alone, or Campaign CRUD via permission set as well?

### The trap

Granting System Administrator "because it works." It **wouldn't have** — the
Marketing User checkbox would still be off. Zara wouldn't notice. Marcus would.
The Week 10 audit certainly would.

### Build

Create Priya using your 1.1 SOP (Platform licence), tick **Marketing User**, and
grant Campaign CRUD through a permission set named `Marketing Campaign Access` —
additive, auditable, removable without touching anyone else's profile.

### Deliverable

A three-sentence email reply to Zara. No jargon, confirms what's done, tells her
what Priya can and can't do. Draft it in `deliverables/`.

---

## Verify everything

`Setup → Users → [user] → Login As`. If it's unavailable, enable it at
`Setup → Login Access Policies`.

- [ ] Ben can see Opportunities, cannot edit Campaigns
- [ ] Priya can create and edit Campaigns, cannot see Finance data
- [ ] Alan and Lisa cannot log in, and own no records
- [ ] Every SOP could be handed to your replacement without a conversation

## Evidence

Screenshot **before you change anything** — the licence page at 4/4, the user
list, the permission set assignment screen. Into `evidence/week-01/`.

Log every change in `build-log.md` with the reason. Including deactivating
OrgFarm EPIC, because in Week 10 you will find an admin account you can't explain
and it would be embarrassing if it were your own.

"# Build Guide — Ticket 1.3: Campaign Access for Priya

## Phase 0 — Ask Zara (three questions, one email)

1. ☐ Send Zara the ticket's three questions. Q2 matters most:
   "all Campaigns vs only hers" decides whether this stays a
   permission set or becomes an org-wide-default/sharing question.
   (If playing solo, sensible assumed answers: marketing headcount;
   all Campaigns — small org; checkbox + permission set.)

## Phase 1 — Create Priya (your own SOP, §1–§2)

2. ☐ Pre-flight: Salesforce Platform licences — should be 6 free
   again after Alan & Lisa were deactivated. Confirm.
3. ☐ Setup → Users → New User, from scratch:
   - Priya Sharma · priya.sharma@sunrise.hossain.dev
   - Licence: Salesforce Platform · Profile: Standard Platform User
   - Role: [per Zara — likely a Marketing role under her; create it
     if the hierarchy lacks one] · Manager: Zara
   - Sydney / en_AU / AUD · untick password email (starts Monday —
     tick it Monday morning instead)
4. ☐ On Priya's user record: tick **Marketing User**. Build-log the
   reason — this is the one checkbox your SOP says never gets
   ticked WITHOUT a reason, and now you have one in writing from
   Zara. That's the difference.

## Phase 2 — Permission set (the auditable half)

5. ☐ Setup → Permission Sets → New:
   - Label: Marketing Campaign Access · no licence restriction
   - Description: "Campaign CRUD for marketing staff. Requested by
     Zara [date], per Ticket 1.3." ← future-audit gold
6. ☐ In the set: Object Settings → Campaigns → Edit → enable
   Read, Create, Edit (Delete only if Zara said so — deleting
   campaigns kills history; reasonable to withhold and say so)
7. ☐ Manage Assignments → Add Assignment → Priya. Save.
8. ☐ Screenshot the assignment screen → evidence/week-01/.

## Phase 3 — Verify (the ticket's full checklist, all four)

9.  ☐ Login As Priya: create a test Campaign, edit it ✓;
    try to browse anything finance-ish ✗
10. ☐ Login As Ben: Opportunities visible ✓; open a Campaign —
    no New/Edit buttons ✗
11. ☐ Alan & Lisa: inactive, cannot log in, own 0 records
    (re-run the 1.2 SOQL if you want it provable)
12. ☐ Delete your test Campaign. Log out of all sessions.

## Phase 4 — The deliverable: Zara's email

13. ☐ Three sentences, zero jargon, into deliverables/. Structure:
    ① done and ready for Monday · ② what Priya CAN do ·
    ③ one boundary + invitation to flag issues.

## Phase 5 — Week 1 closeout (the ticket's Evidence section)

14. ☐ evidence/week-01/: licence page, user list, permission set
    assignment screenshots
15. ☐ build-log.md current — EPIC deactivation reasoning included
16. ☐ The replacement test: reread all three SOPs — could a
    stranger run them without calling you?"

# "For step 13, Hi Zara — Priya's all set up and ready for Monday morning; she can create and edit Campaigns from day one. I've given her marketing access through a dedicated permission group, so if her role grows we can extend it cleanly rather than working around it. One note: I've held off on campaign deleting for now (it wipes reporting history) — if she needs it, just reply here and it's a two-minute change. — Hemayet"

---

## Ask Claude to play Marcus

When the SOPs are drafted:

> _"Play Marcus. Review my User Provisioning SOP and my status message like you'd
> review a real intern's work. Be as blunt as he is."_

And for 1.2:

> _"Play Marcus. Push back on my dormant user report — where am I missing something?"_
