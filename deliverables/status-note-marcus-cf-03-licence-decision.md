# Status note to Marcus — the licence decision, as three costs

**29/08/2026 · CF-03 · Raised 19/08. Unanswered for ten days.**

This is not a question. Below are the three things that can happen and what each one
costs. **All three are already being chosen from — (c) is the one running right now,
and it has been running for ten days without anyone saying so.**

---

> **⏱ As at 01/09/2026.** This note is dated 29/08 and is correct as written. One
> count has moved: *"Raised 19/08. Unanswered for ten days"* is now **thirteen days**,
> and (c) has been running that long. The licence position is unchanged — **Salesforce
> still 4 of 4**, re-read from the org today. The three costs and the recommendation
> stand.

## Delivery

| | |
|---|---|
| **To** | Marcus |
| **Channel** | ✅ **`SunRise Ops — Escalations`** Chatter group (`0F9gK000000YDsTSAW`) — @mention **Marcus Head**, `marcus.head@sunrise.hossain.dev`, Chatter Free, created 29/08. **Resolved by CF-22.** **⚠️ Superseded 01/09: Marcus Head is deactivated.** Live recipient is **Marcus Neil** (`005gK00007HBpc5QAD`, `hossainconsulting+marcus@gmail.com`), in the same group. Posts from 29/08 still @mention the dead account — see CF-22. |
| **Audit copy** | Chatter, addressed to nobody, so the reasoning sits in the org for whoever opens it next |

Per [sop-escalating-rule-changes.md](sop-escalating-rule-changes.md) v1.1. **This note is
not finished until the Channel row is filled in.**

## The message

> *"The licence decision has been open ten days and it's now blocking five things, so
> here it is as three costs rather than another question. (a) Buy two Salesforce seats —
> that's money, and two is the floor, not the number. (b) Move someone to Platform — I've
> checked what Platform actually opens in our org and it's Accounts and Contacts, nothing
> else, so it fits almost nobody. (c) Carry on as we are — which is what we're doing, and
> the cost is that two people have no system and nobody outside this thread knows it.
> I'm not proposing (b) for Jack and Mia any more; I recommended that in Week 1 and I was
> wrong. Pick one and I'll execute it this week."*

---

## Verified in the org today, not carried forward from notes

| | |
|---|---|
| **Salesforce** | **4 of 4 used** — Hemayet (admin), Ben Carter, Jack Nguyen, Mia Kelly |
| **Salesforce Platform** | **1 of 6 used** — Priya Sharma. Five free |
| Ever logged in | **Hemayet only.** Ben, Jack, Mia and Priya all show `LastLoginDate` = never |

## What the decision is now blocking

1. **Two of the three Monday hires** — the second Newcastle rep and the Wollongong
   service tech. Never provisioned.
2. **Priya cannot do her job.** She is the Marketing Coordinator, on a Platform licence,
   with `Marketing User` = false. Platform has no Campaign object at all.
3. **Jake has no user account of any kind.** This is now blocking three separate things,
   not one: he cannot receive the pipeline report (Ticket 2.3), he is the proposed owner
   of the duplicate queue (CF-07), and he is the obvious person to make CF-02's six
   address confirmation calls. **Every open control in this org points at a man who
   cannot log in.**
4. **`Marketing Campaign Access` permission set** (CF-18) — deliberately not built,
   because permission sets are constrained by licence type and it would grant Priya
   nothing while she is on Platform.
5. **CF-04**, the 666 unowned Opportunities — see the carve-out at the foot of this note.

---

# The three costs

## (a) Buy two Salesforce licences

**The cost is money, and it is the only one of the three with a number I cannot look up
for you** — two seats at whatever SunRise's contracted rate is, recurring, not one-off.

**What it buys:** the two Monday hires, provisioned properly, this week. Nothing else on
the list above.

**The honest part: two is the floor, not the number.** Counting what the org actually
needs rather than what was asked for on the 19th:

| Who | Needs | Licence that provides it |
|---|---|---|
| Second Newcastle rep | Opportunity | Salesforce |
| Wollongong service tech | Case | Salesforce |
| Priya Sharma | Campaign | Salesforce |
| Jake | a login at all | Salesforce |

**Four, not two.** Two closes the ticket you raised on the 19th. Four closes the org.
I am not asking for four — I am telling you that buying two and considering the problem
solved will put us back here inside a month, with Priya and Jake still stuck.

## (b) Move someone to Platform

**The cost is that it fits almost nobody, and I can now say exactly how few.**

I checked what a Standard Platform User in *our* org can actually open. The complete
list of business objects is:

> **Account. Contact.**

That is it. The rest of the profile's access is consent and privacy plumbing —
`AuthorizationForm`, `ContactPointEmail`, `DataUsePurpose` and similar. There is **no
Opportunity, no Campaign, no Case, no Lead, no Solution.**

The other thing a Platform licence normally buys is custom objects. **SunRise has none** —
every `__c` object in the org is Salesforce's own system furniture. So Platform here is
Accounts and Contacts and nothing more.

**Against that list:**

- **The Wollongong service tech needs Cases.** Platform has no Case. Ruled out — and
  this is new information; it was not knowable when the options were first drafted.
- **Priya is the worked example, not a hypothesis.** She is on Platform today and cannot
  create a Campaign. This is what the option looks like after it has been taken.
- It works for a user whose entire job is Accounts and Contacts. **There is nobody on
  the current list who that describes.**

So (b) is real but nearly empty. The five free Platform licences are not the answer they
look like on the Company Information page.

### Not offering (b) for Jack and Mia — and that is a reversal

**This was my Week 1 recommendation and it was wrong.** I proposed converting or
deactivating Jack and Mia as the cheapest way out of the licence wall. CF-04 has since
shown that both variants damage data.

| Owner | Opportunities | Open | Open value |
|---|---|---|---|
| Jack Nguyen | 221 | 37 | $466,560 |
| Mia Kelly | 221 | 37 | $473,344 |
| **Between them** | **442** | **74** | **$939,904** |

Moving them to Platform leaves each of them **owning 442 records their licence cannot
open.** It is the identical wall Priya is standing at with Campaigns, except pointed at
$939,904 of pipeline instead of one person's task list. Deactivating them instead orphans
the same 442.

**Their 442 Opportunities have to go to a named person before either lever is touched.**
That is CF-04, it is still unanswered, and it is a separate decision from this one — but
it gates this one. I would rather tell you that now than execute a Week 1 recommendation
that I have since found to be unsafe.

## (c) Leave the hires unprovisioned, and say so out loud

**This is free, it is the status quo, and it is what we are doing.**

**The cost is not the unprovisioned users. It is that the cost is currently being paid
silently.** Two people were set up to start on a Monday and have no system. Ten days on,
that fact lives in my build log and in this thread and nowhere else.

Choosing (c) deliberately is defensible — small orgs run short-handed and a licence spend
may genuinely not be worth it this quarter. **Choosing it by not answering is not**,
because the people absorbing the cost do not know they are absorbing it.

If (c) is the answer, it needs saying to four places, and I will send them the day you
tell me: **HR**, who sent through details for three hires; **Sarah**, who was to specify
the service tech's access; **Jake**, who is short a rep and is the one being asked to
carry every control in this org without a login; and **the two hires themselves.**

---

## The ask

**One of (a), (b) or (c), by reply.** Not a meeting.

If it is **(a)**, tell me two or four, and I will provision against whichever arrives.
If it is **(b)**, tell me who — and it cannot be Jack or Mia until CF-04 is answered.
If it is **(c)**, say the word and I will send the four notes above today.

**And CF-04 separately, because it gates all of this:** who inherits Jack's and Mia's 442
Opportunities? Ben Carter is the only unencumbered Standard User in the org and he is one
Newcastle rep. There is no comfortable answer, which is why it needs to be yours.

— Hemayet
