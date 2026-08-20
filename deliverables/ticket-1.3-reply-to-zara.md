# Reply to Zara — Campaign access for Priya Sharma

**21/08/2026** · Draft — check the licence position before sending.

---

**Subject:** Re: Campaign access

Hi Zara — thanks, and welcome back to having an admin.

Priya's account is set up and she'll be able to log in Monday. **Campaign access
isn't possible yet**, though, and I'd rather tell you now than have her find out on
her first day: creating and editing Campaigns needs a full Salesforce licence, and
all four of ours are currently in use.

I've asked Marcus to decide between buying a licence or freeing one up, and I'll
have Priya's Campaign access switched on the same day that's resolved.

— Hemayet

---

## What Priya can and can't do right now

**Can:** log in, see Accounts and Contacts, run and build reports and dashboards,
use Chatter.

**Cannot:** see or touch Campaigns at all — not create, not edit, not view.

## Why — the bit that isn't in Zara's email

Two separate walls, and the second one only appears once you've climbed the first.

**1. The Marketing User checkbox.** Campaign create, edit and delete are gated by
a checkbox on the *user record*, not by the profile. Object permissions can say
yes and the save still fails. This is what produced the Phase 0 error:

```
DML operation Delete not allowed on Campaign
```

It's off by default, including for System Administrators.

**2. The licence type — this is the real blocker.** Attempting to set Marketing
User on Priya's Platform-licence account returns:

```
FIELD_INTEGRITY_EXCEPTION :: Marketing User is not allowed for this License Type
```

Salesforce Platform licences do not include Campaigns **at all**. Verified against
the org: `Campaign` has no object-permission row for the `Standard Platform User`
profile, only for `Standard User`. So there is nothing to grant — no profile
change, no permission set, no checkbox will produce Campaign access on a Platform
licence, because the object isn't in the licence.

A permission set named `Marketing Campaign Access` was planned for this ticket and
has **not** been built. Permission sets are constrained by licence type too, so it
would grant nothing until Priya is moved to a Salesforce licence. Building it now
would look like progress and deliver none.

## The trap I avoided, and the better one underneath it

The obvious wrong answer is granting **System Administrator** "because it works."
It wouldn't have — the Marketing User checkbox would still be off, and Zara
wouldn't have noticed while I handed a marketing coordinator full org access.

But the less obvious wrong answer is following the ticket literally: *"create Priya
on a Platform licence and tick Marketing User."* That instruction cannot be
carried out. Discovering that early is the whole value of checking licence type
before building — the same lesson as Ticket 1.1, arriving from a different
direction.

## Current state

| | |
|---|---|
| Priya Sharma | Created, active, `Standard Platform User`, Title *Marketing Coordinator*, Manager set, `Australia/Sydney`, `en_AU` |
| Password email | Suppressed — she starts Monday |
| Marketing User | **Not set** — not permitted on this licence type |
| Campaign access | **None** — object not available on Platform |
| `Marketing Campaign Access` permission set | **Not built** — deferred until the licence is resolved |

## To finish this ticket once a licence is available

1. Move Priya to a **Salesforce** licence (profile → `Standard User`).
2. Tick **Marketing User** on her user record.
3. Build the `Marketing Campaign Access` permission set — Campaign Read, Create,
   Edit — and assign it. Additive, auditable, removable without touching anyone
   else's profile.
4. Verify with **Login As**: she can create and edit a Campaign, and cannot see
   Finance data.
5. Reply to Zara confirming it's live.

> ✍️ **TODO before sending:** the brief asks for a three-sentence reply with no
> jargon. The draft above is close — read it aloud and cut anything Zara would
> have to ask you to explain. She does not need to know what a permission set is;
> she needs to know when Priya can run a campaign.
