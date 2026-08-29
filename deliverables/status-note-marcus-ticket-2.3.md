# Status note to Marcus — Ticket 2.3 (the pipeline, and the licence decision)

**26/08/2026** · Every figure below was read back out of the org.

---

## Delivery

> ⚠️ **Never sent. Added 29/08 — see CF-22.** **Marcus has no user account in this org**,
> so the Chatter route this note names reached nobody. **It opens with "Hold the licence
> decision — it isn't safe yet." He never received that**, and CF-03 has been sitting
> open on his desk ever since.

| | |
|---|---|
| **To** | Marcus |
| **Channel** | ✅ **`SunRise Ops — Escalations`** Chatter group (`0F9gK000000YDsTSAW`) — @mention **Marcus Head**, `marcus.head@sunrise.hossain.dev`, Chatter Free, created 29/08. **Resolved by CF-22.** |
| **Audit copy** | Chatter on the pipeline report or one of the affected Opportunities |

## The message

Per [sop-escalating-rule-changes.md](sop-escalating-rule-changes.md) this was to go the
moment it was known, not into a document read next week:

> *"Hold the licence decision — it isn't safe yet. Jack and Mia own 221 Opportunities
> each, $939,904 of open pipeline, despite never having logged in. Deactivating them
> orphans all of it exactly the way OrgFarm EPIC's 224 already are; moving them to
> Platform is worse, because Platform licences can't see the Opportunity object at
> all. Proposing we reassign the pipeline to a named owner first, then re-licence.
> Two things I need from you: who inherits it, and whether the stale-pipeline
> threshold is 30 days or 14. OK?"*

The rest of this note is the detail behind it.

---

Marcus — Jake's forecast answer is below, but **the more important thing I found
while getting it is that the licence decision you were asked for in Week 1 cannot be
executed safely today.** That is the ask.

---

## First, Jake's number, because he needs it by Friday

**$702,336 of open pipeline is sitting on a close date that has already passed** —
56 Opportunities, **37% of everything open**. All of it is in the forecast right now.

The number you should actually quote is **$188,224**. That is the same pipeline
weighted by probability, and it is the defensible one: the raw figure counts a 10%
Prospecting deal exactly like a 60% one. Both totals are on the report so nobody has
to recompute it.

**I have closed nothing and re-dated nothing.** Those are recommendations for Jake to
execute on his own pipeline. The full per-Opportunity list is in
[ticket-2.3-pipeline-hygiene-report.md](ticket-2.3-pipeline-hygiene-report.md).

One thing worth knowing: the number was 51 when the ticket was written, 55 on Monday,
and **56 this morning** — one crossed its date overnight while I was writing this. A
list triaged by hand is wrong again the next day, which is why I set the report to
email itself out every Monday rather than doing this as a one-off.

---

## 1. The licence decision is not safe to execute — this is the ask

You were asked in Week 1 to decide between deactivating Jack and Mia or moving them
to cheaper licences, on the grounds that they hold two of our four Salesforce
licences and have never logged in. It was the cheapest unblock. **Both halves of it
would cause real damage today, and I only know that because I went looking.**

| | Opportunities | Open | Open value |
|---|---|---|---|
| Jack Nguyen | 221 | 37 | $466,560 |
| Mia Kelly | 221 | 37 | $473,344 |
| **Together** | **442** | **74** | **$939,904** |

**Deactivate them** and those 442 Opportunities are orphaned — owned by someone who
cannot be assigned work, cannot be emailed, and cannot action anything. Salesforce
will not warn you. It does not treat record ownership as a blocker.

**Move them to Platform licences** and it is worse, not better. Platform licences have
**no access to the Opportunity object at all** — there is no permission row for it, so
no permission set or profile change can grant it. This is the identical wall we hit
with Priya and Campaigns in Ticket 1.3. They would keep owning 442 Opportunities they
could no longer open.

**"Has never logged in" is not the same as "owns nothing."** That was the assumption
underneath the Week 1 recommendation, including mine, and it was wrong.

### It has already happened once

**OrgFarm EPIC still owns 247 records** seven days after we deactivated it — 224
Opportunities, of which **38 are open and worth $481,280**, plus 13 email templates
and 10 solutions.

When we deactivated it on the 19th, Salesforce made us clear six system references
first, one at a time, and refused to proceed until each was fixed. It never once
mentioned the 224 Opportunities, **because record ownership does not block
deactivation.** The org protects itself and stays quiet about your data. We did the
thorough-feeling part and missed the part that mattered.

I have to correct something I told you yesterday: I reported EPIC's exposure as
$178,432. **That was only the portion also past its close date.** The real open figure
is $481,280. I had measured what my report could see rather than what the user
actually owned.

### What I propose

**Reassign the pipeline to a named owner first, then re-licence or deactivate.** Same
fix for both options, and it makes both safe. Nothing else needs to change.

---

## 2. Who inherits — and the uncomfortable answer

I can do the reassignment in minutes. I cannot decide who receives it, and there is a
problem with the obvious candidates.

**Hemayet is the only person who has ever logged into this org.** Ben Carter, Jack
Nguyen, Mia Kelly and Priya Sharma have a `Last Login` of never — all four.

So all 890 Opportunities in the org belong to four accounts:

| Owner | Opportunities | |
|---|---|---|
| Hemayet Hossain | 224 | the admin, not a salesperson |
| OrgFarm EPIC | 224 | **deactivated** |
| Jack Nguyen | 221 | never logged in |
| Mia Kelly | 221 | never logged in |

**There is no working salesperson owning anything.** That is also the reason Jake's
triage stalls: 42 of the 56 stale Opportunities come back "ask the owner", and for
three-quarters of them there is no owner to ask.

Ben Carter is the only unencumbered Standard User, but he is one Newcastle rep and
handing him the entire company's pipeline is not a real answer either.

**So the question is genuinely yours: who are the salespeople?** If the answer is
"Jack and Mia, once they actually start", then the fix is to get them logged in rather
than to take their licences away — which reverses the Week 1 recommendation, and is
worth knowing before you act on it.

---

## 3. Thirty days or fourteen — one number, please

Two thresholds are in play and I would rather run one:

- **30 days past close** — the standing rule as drafted. Catches 26 Opportunities,
  $323,840.
- **14 days past close** — what I used to split "chase now" from "chase soon" in the
  triage. Catches 42, $535,424.

Both are defensible. Running both is how numbers start drifting, which is the problem
this ticket exists to fix. **Pick one and I will align the report, the rule and the
Monday email to it.**

---

## 4. Still waiting on you from last week

Neither of these has been answered, and both are live in the org right now:

- **Block on create** is switched on for duplicate accounts. A rep whose customer has
  a fat-fingered phone number matching an existing record **cannot save**. That cost
  lands on your team. Confirm it, or I will drop it back to alert in five minutes.
- **Nobody owns the duplicate queue.** This is the control that actually failed in
  2024 — 74 alerts sat unread. I proposed Jake, Mondays, ten minutes. I cannot roster
  him. Can you?

---

## What I changed without asking, and why

The triage rule I was given sorts Opportunities by activity history and by being more
than 90 days overdue. **Neither exists here** — there is no activity history anywhere
in the org, and nothing is more than 56 days past its date. As written, every one of
the 56 fell into a single bucket, which is not a triage.

I substituted days-past-close, the only signal the data actually holds. **I left the
"close it" threshold at 90 days, which means it selects nothing.** I could have
lowered it to make the report look complete, and I am not going to recommend closing a
customer's deal because a number needed filling in. If you want a list of deals to
kill, the honest way to get one is for Jake to make some calls.

Telling you now rather than in the write-up is the whole point of the SOP we wrote
after last time.

## One mistake, caught and fixed

Deploying the report folder wiped Jack's and Mia's access to it, while leaving the
Monday subscription in place — so the email would have kept sending to two people who
could no longer open the report. A control that looks green and does nothing, which is
precisely the failure mode we spent Ticket 2.2 fixing. Found it in the same session,
fixed it, and made the sharing part of the versioned config so a future deploy cannot
repeat it.

Worth saying plainly because the subscription is a control you are relying on: it is
verified working now, and I checked rather than assumed.

— Hemayet
