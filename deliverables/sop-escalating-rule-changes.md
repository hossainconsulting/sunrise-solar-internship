# SOP — When an approved rule breaks

**SunRise Solar · Owner: Hemayet Hossain · v1.0 — 25/08/2026**

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

Post it where the approver will see it. In this org that is Chatter on the record
or the ticket. Then keep working; you are informing, not requesting permission to
breathe. If the change is irreversible, wait for the reply.

## What it is not

- **Not a status update.** Only send it when a rule *changed*.
- **Not an apology.** A rule that breaks on real data is normal.
- **Not a substitute for the build log.** The log records what happened; this
  message makes sure nobody learns it from the log.

## The test

> Could the approver be asked, tomorrow, what method was used — and give the right
> answer without reading anything I wrote?

If no, send the message.
