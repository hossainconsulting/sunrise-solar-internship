# SOP — When an approved rule breaks

**SunRise Solar · Owner: Hemayet Hossain · v1.1 — 29/08/2026**
*(v1.0 25/08/2026 · v1.1 29/08 — the delivery instruction was unexecutable; see
"Where to send it")*

**Scope:** one page. What to do the moment a rule someone signed off stops working
against real data.

---

## The rule

> **When an approved rule fails on contact with the data, that is a message to the
> approver — before you proceed, not in the write-up afterwards.**

One line. Sent at the moment of discovery. Then carry on.

---

## Why this exists

On 25/08/2026, Marcus approved this merge rule:

> "Two Accounts are the same customer when their phone numbers match; the surviving
> record is the one with the most recent won Opportunity, and any group without a
> clear winner is held for review rather than merged."

Both halves failed within the hour. Phone matching missed 127 duplicates because
many records have no phone. "Most recent won Opportunity" selected no unique
survivor in most groups, because either several records had won Opportunities or
none did.

Adapting was correct — name-matching with a record-age fallback was a reasonable
substitute, and the work could not proceed otherwise.

**Not telling him was the mistake.** He learned that the methodology had changed by
reading the audit. His words: *"I approved a rule, something else happened, and I'm
reading about it afterwards. If Sarah asks me what methodology we used, I'd have
said the wrong thing this morning."*

**The cost was asymmetric.** One Chatter line on the 25th —

> *"Phone matching is missing 127 dupes because a lot of records have no phone.
> Proposing name + record age for the groups I've cross-checked. OK?"*

— would have removed half of Marcus's Monday list. Thirty seconds against a
credibility problem that took a full audit section to repair.

## When it applies

Send the message when any of these is true:

- The **matching or selection criterion** you were given doesn't discriminate
- You are substituting a **different field, key, or fallback** than the one approved
- The **scope** turns out to be larger, smaller, or a different shape than agreed
- You are about to do something **irreversible** under a rule that has already bent

## What the message contains

Four things, in one or two sentences. No document, no meeting.

1. **What broke** — the specific failure, with a number if you have one
2. **Why** — the data reason, not an apology
3. **What you propose instead** — a concrete substitute, not a question in the air
4. **Ask** — "OK?"

Then keep working; you are informing, not requesting permission to breathe. If the
change is irreversible, wait for the reply.

## Where to send it

> **v1.0 said: _"Post it where the approver will see it. In this org that is Chatter on
> the record or the ticket."_ That instruction has never been executable, and it took
> four weeks and six documents to notice.**

**Marcus has no user account in this org.** Neither do Jake, Sarah or Zara. There are
also **no Chatter groups** — none, not one. The only people who can receive a Chatter
post here are Ben Carter, Jack Nguyen, Mia Kelly and Priya Sharma, three of whom have
never logged in.

So every escalation written in Weeks 1 and 2 was addressed to a channel that could not
reach its recipient, and each one read as delivered because it had a **"line to post
now"** at the top.

### The rule that replaces it

> **Before you write the line, confirm the recipient can receive it. Name the channel
> in the note itself.**

One check, once per recipient, and it takes ten seconds:

1. **Setup → Users.** Is the approver there, and **Active**?
2. If **yes** — Chatter on the record or the ticket, and @mention them. This is the
   preferred route: it puts the message next to the data it is about, and it is visible
   to whoever comes next.
3. If **no** — Chatter is not a channel, it is a filing cabinet. **Send it by whatever
   that person actually reads** (email, Teams, in person), and then **post the same text
   to Chatter on the record anyway**, addressed to nobody.

Step 3's second half is not busywork. Chatter is doing two jobs and only one of them
needs the recipient to exist:

| Job | Needs a user account |
|---|---|
| **Reaching** the approver | Yes |
| **Leaving the reasoning beside the record** for whoever opens it next | No |

The audit trail is worth having even when the notification is impossible. What is not
acceptable is doing the second and believing you did the first.

### What every status note must now carry

Not *"the line to post now"* — that phrasing assumes the channel. Instead:

> **To:** Marcus · **Channel:** email — *no user account in the org*
> **Audit copy:** Chatter on `<record>`

If the channel line cannot be filled in, the note is not finished.

## The second test

> **Can the person I am writing to actually receive this, today, by the route I have
> written at the top of it?**

If no, the note is a diary entry. Change the route before you send it.

## What it is not

- **Not a status update.** Only send it when a rule *changed*.
- **Not an apology.** A rule that breaks on real data is normal.
- **Not a substitute for the build log.** The log records what happened; this
  message makes sure nobody learns it from the log.

## The test

> Could the approver be asked, tomorrow, what method was used — and give the right
> answer without reading anything I wrote?

If no, send the message.
