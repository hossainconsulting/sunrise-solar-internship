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
4. Who does each report to? *(Manager field drives approval routing in Week 5.)*
5. Any permission sets beyond the profile — Marketing User, Knowledge User?
6. Is there an existing onboarding SOP, or am I writing one?

Question 6 is the one Marcus is actually waiting for.

### The licence wall — and it's real

Check `Setup → Company Information` before you start. You have **4 Salesforce
licences and all 4 are in use**: OrgFarm EPIC, you, Jack Nguyen, Mia Kelly.

You cannot create three new Salesforce users. This is not a flaw in the exercise —
it is the most common Week 1 reality in a small org, and how you handle it *is*
the deliverable.

**Do this:**

- Deactivate **OrgFarm EPIC** (`Setup → Users → Edit → untick Active`). It's
  Salesforce's provisioning account, it has never logged in, and it's consuming a
  licence. Freeing it is a defensible admin decision — write the justification in
  your build log.
- Create **one** new hire properly against that licence: `Ben Carter`, Newcastle
  sales rep, Standard User, Manager set, Australia/Sydney, en_AU.
- For the other two, write the provisioning record but don't create the users.
  Your status note to Marcus says: *"Two of three provisioned. We're at licence
  capacity — I've freed one by deactivating an unused system account. The third
  and fourth need either a licence purchase or two deactivations. Which would you
  prefer?"*

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
- The Marketing User checkbox, and that it is *not* a profile permission
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
4. Do we have a Freeze-before-Deactivate process? *(Freeze locks login without
   releasing the licence — the right move during a contested exit while legal
   decides.)*
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

Checklist format. Must include the Freeze-vs-Deactivate distinction and *why* —
that one paragraph is what makes it read as written by a professional.

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
2. All Campaigns, or only ones she owns? *(OWD implications.)*
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

---

## Ask Claude to play Marcus

When the SOPs are drafted:

> *"Play Marcus. Review my User Provisioning SOP and my status message like you'd
> review a real intern's work. Be as blunt as he is."*

And for 1.2:

> *"Play Marcus. Push back on my dormant user report — where am I missing something?"*
