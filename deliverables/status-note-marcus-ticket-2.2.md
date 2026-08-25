# Status note to Marcus — Ticket 2.2 (stopping the duplicates coming back)

**25/08/2026** · Every rule state below was read back out of the org.

---

## The line to post now

Per `sop-escalating-rule-changes.md`, this goes to Chatter the moment it is
known, not into a document Marcus reads next week:

> *"Heads up — the phone rule you approved can't catch what's left. Nothing in
> the org shares a phone number any more, but 13 addresses still hold two
> accounts each. I've added a second rule on name + address that alerts rather
> than blocks, and left the phone rule blocking. Two things I need from you:
> confirm Block-on-create is what you want, and tell me whether Jake can own the
> duplicate queue on Mondays. OK?"*

The rest of this note is the detail behind it.

---

Marcus — the duplicate rules are built, tested and live. **Three things need you,
and one of them is a mistake I made and fixed.**

## What is live now

New accounts with a phone number that already exists are **refused**, not warned
about. New accounts at an existing address with a similar name get an **alert**
and land in a review queue. Anyone typing "Residence" into an account name is
**stopped**, with the naming standard in the error message.

I tested all of it by trying to create the duplicates deliberately, including
the trick a bulk import uses to skip warnings. The blocks held. Evidence is in
`evidence/week-02/ticket-2.2-before-after-test.txt`.

## 1. The rule you approved doesn't fit what's left — I changed it

You approved phone matching in 2.1. I've kept it, and it blocks. But **no two
accounts in the org share a phone number any more**, so on its own it now
catches nothing. What is still duplicated is `Andrew Anderson Residence` and
`Andrew J. Anderson Residence` — one household, one address, a landline on one
record and a mobile on the other. Phone matching cannot see that. Neither could
the rule as I first built it.

So I added a second rule matching on name plus street. It **alerts** rather than
blocks, because two accounts at one address can be genuine — a landlord and a
tenant, a subdivided block — and I would rather ask a person than tell them they
are wrong.

I'm telling you now rather than in the write-up. That's the whole point of the
SOP we wrote after last time.

## 2. Block on create — I need you to own this

Block is live. It is the right call and it is also the one with a cost: a rep
entering a real new customer whose phone was fat-fingered to match an existing
one **cannot save**, and will call you or me instead of finishing the sale. That
is the trade for stopping the next import creating 300 records.

I've set it to Block because the 2024 mess came in through an import, and an
alert cannot stop an import — only a block can. But you said it yourself when we
scoped this: that cost lands on your team, not mine. **Confirm it, or tell me to
drop it back to alert and I'll change it in five minutes.**

## 3. Somebody has to read the queue — I'd like it to be Jake

This is the control that actually failed. There were **74 duplicate alerts
already sitting in the org** when I started. Salesforce spotted the duplicates
in 2024. It flagged every one of them. Nobody ever opened the list.

Building better rules changes nothing if the same thing happens again, so:
**Jake, Mondays, ten minutes.** He is already the one who checks a customer by
ringing them, which is exactly the judgement this queue needs.

I can't roster Jake. **Can you?**

## The mistake, and what it cost

The naming-standard rule I built this morning fired on every save, not just on
new records. For part of today, **all 47 accounts with "Residence" in the name
could not be edited at all** — not the phone, not the address, not the owner.
Anyone touching one would have got a lecture about naming standards for a change
that had nothing to do with the name.

I found it while testing, fixed it within the hour, and added a permanent check
to the test script so it cannot come back. Nobody hit it as far as I can tell,
because nobody else was in the org. But it would have been a bad Monday, and it
was avoidable — I wrote the rule and didn't test the edit path until afterwards.

## One thing that is deliberately not fixed

**The 10 middle-initial pairs are still there, on purpose.** We decided in 2.1
to hold them rather than merge on name similarity, and there is a HOLD task on
all twenty records due 08/09. The new rules don't touch them — they stop the
next duplicate, they don't clean up old ones.

That's the right call and I'm not asking you to change it. I'm flagging it
because until those pairs are confirmed by phone, the customer number stays a
range — 41 to 51 — and the freeze point for the board pack is COB Thursday.

Worth one line, though: the new household rule catches exactly this pattern. If
it had existed in 2024 these ten would have been a question at the point someone
typed them in, not a fortnight of merge work two years later. That's the honest
answer to "how did we end up with five of everything" — not that the technology
was missing, but that it was set to warn and nobody was listening.

— Hemayet
