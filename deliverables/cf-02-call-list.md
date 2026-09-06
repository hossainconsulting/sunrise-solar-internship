# CF-02 — The six calls

**SunRise Solar · Org `sunrise` · Written 03/09/2026 · Owner: Hemayet Hossain**
**Commitment: the six calls this week — expires COB Friday 04/09/2026. 0 of 6 made.**

Companion to [cf-02-address-confirmations.md](cf-02-address-confirmations.md), which
records why these six accounts carry an unconfirmed address. This document is the list to
work from, in order, with what to ask.

---

## Two corrections to CF-02 before the first call

### ① The discarded addresses are recoverable — CF-02 says twice that they are not

[cf-02-address-confirmations.md](cf-02-address-confirmations.md) states *"The discarded
addresses are not recoverable from the org"* and *"the discarded addresses remain
unrecoverable"*. That was the stated reason the calls are the only route.

**They are in the repo.** [`evidence/week-02/accounts-pre-merge-reconstructed.csv`](../evidence/week-02/accounts-pre-merge-reconstructed.csv),
captured 25/08, holds all 23 pre-merge records for these six households with every
`BillingCity` and `BillingPostalCode` intact. Per [merge-log.md](merge-log.md) it was built
by querying `Account` with `IsDeleted = true AND MasterRecordId != null --all-rows` — so
the absorbed rows were still live in the org's recycle bin when it ran.

> **This is the CF-14 pattern again.** CF-14 declared Week 1's evidence lost without
> opening the folder; the screenshots were in OneDrive the whole time. Here a document
> declared the addresses unrecoverable while the file that contains them sat two
> directories away, committed, and cited by the same document's own evidence links.

**What it does not do is answer the question.** Recovering three candidate suburbs does not
say which one the customer lives in — all three were seeded on 17/08 by the same load and
none is more authoritative than another. **The calls still have to happen.**

**What it does change is the call.** It turns an open question — *"what is your service
address?"* — into a closed one: *"is it Campbelltown, Chatswood, or Penrith?"* That is
faster, far more likely to be answered correctly on a first attempt, and much less likely
to introduce a fresh transcription error.

**One thing that does expire:** the absorbed rows were merge-deleted on 24/08. Salesforce
holds deleted records for 15 days, so org-side recovery lapses around **08/09**. The data
itself is safe — it is committed to the repo — but if anything further needs pulling from
those rows directly, it needs pulling before then. *Unverified: this is the standard
retention window, not a queried fact. Worth one `--all-rows` query to confirm.*

### ② The street address never varies. Only the suburb does.

Across all 23 pre-merge records, **every record in a group shares the same street** —
`111 Sunset Rd`, `23 Beach Rd`, `67 Railway Pde`. The only fields in conflict are
`BillingCity` and `BillingPostalCode`, and only ever across three values:
**Campbelltown 2560, Chatswood 2067, Penrith 2750.**

So the dispatch risk is narrower than "the address is unknown". The house number and street
are consistent; the suburb is the open question. That is one question per call.

---

## Call order — and it is not alphabetical

Each retained suburb can be scored against the other records in its own merge group, and
against the account's CF-20 pair partner. **Read the caveat below before using this.**

| # | Household | Retained | In-group support | Pair partner says | Risk |
|---|---|---|---|---|---|
| **1** | **Oliver Murphy** | **Campbelltown 2560** | **1 of 4** — Chatswood has 2 | **Chatswood ✗** | **🔴 Highest** |
| **2** | **Samuel Fitzgerald** | Chatswood 2067 | **1 of 4** — Penrith has 2 | Chatswood ✓ | 🟠 High |
| **3** | **Lucas Tran** | Chatswood 2067 | 1 of 3 — no majority exists | Chatswood ✓ | 🟡 Medium |
| 4 | Andrew Anderson | Campbelltown 2560 | 2 of 4 | Campbelltown ✓ | 🟢 Lower |
| 5 | Daniel Clark | Campbelltown 2560 | 2 of 4 | Campbelltown ✓ | 🟢 Lower |
| 6 | Joshua Patel | Penrith 2750 | 2 of 4 | Penrith ✓ | 🟢 Lower |

> ### ⚠️ This ranking orders the calls. It must never change an address.
>
> Counting duplicates is **not** evidence of truth. All 23 records were bulk-seeded on
> 17/08 and the suburb spread is combinatorial — the "majority" is an artefact of how the
> seed generator ran, not a signal about where anyone lives. Treating a duplicate count as
> evidence is precisely the substitution
> [ticket-2.1-data-quality-audit.md](ticket-2.1-data-quality-audit.md) §③ and §④ already
> record as the mistake, and it is the same reflex that picked these six addresses by
> record age in the first place.
>
> **It is used here for one thing only: deciding who to ring first when there is time for
> three calls and not six.** It costs nothing and beats alphabetical order.

**Murphy is the exception worth taking seriously**, because a second, independent finding
already points at it. CF-20 records that *"9 of 10 share a suburb"* across the ten
middle-initial pairs. **Murphy is the one that does not** — `Oliver Murphy Residence` sits
in Chatswood while `Oliver J. Murphy Residence` sits in Campbelltown. That was found by a
different method, on a different ticket, before this ranking existed. Two independent
routes landing on the same record is worth more than either alone.

---

## One call closes three tickets

**The six CF-02 accounts are the "J." halves of six of CF-20's ten pairs.** Verified against
[`accounts-post-merge.csv`](../evidence/week-02/accounts-post-merge.csv): all ten pairs
exist, and Anderson, Clark, Patel, Tran, Murphy and Fitzgerald are on both lists.

And the **Contact** duplicate groups for these same households sit under the non-`J.`
Accounts, carrying the same three-suburb `MailingCity` spread — verified in
[`cf-13-post-merge.csv`](../evidence/week-02/cf-13-post-merge.csv). That is CF-13 Bucket B.

So a single call to Oliver Murphy answers all three:

| Ticket | Question that call answers |
|---|---|
| **CF-02** | Which suburb is the service address on `Oliver J. Murphy Residence`? |
| **CF-20** | Are `Oliver Murphy Residence` and `Oliver J. Murphy Residence` the same household? |
| **CF-13 B** | Which `MailingCity` survives on the Murphy Contact group? |

> **The register carries these as three tickets with two different deadlines — 04/09 and
> 08/09 — and they are the same six phone calls.** The register already suspected this:
> *"three separate holds now wait on customer contact that nobody is rostered to make…
> one job for one person, currently filed as three tickets."* This confirms it and puts
> numbers on it.

**The arithmetic changes accordingly.** Yesterday's count was 37 conversations. It is not:

| | Calls |
|---|---|
| The six CF-02 households — closes CF-02, 6 of CF-20's 10, and their Bucket B groups | **6** |
| CF-20's remaining four — Kowalski, Bennett, Young, Singh | **4** |
| CF-13 Bucket B groups in households not on either list | ~11, to be confirmed |
| **Total** | **~21, not 37** |

**Ten calls close CF-02 and CF-20 completely.** Six of them are due tomorrow.

---

# The six

Ring the **mobile** first — it is the number on the flagged account. The **landline** is the
CF-20 pair partner's number and reaches the same household; getting the same person on both
*is* the CF-20 confirmation. Absorbed mobiles are fallbacks only.

---

## 1 🔴 Oliver Murphy — `001gK00001Luv6zQAB`

| | |
|---|---|
| **Ring** | **0410 364 274** · landline **(02) 4174 1186** |
| Fallbacks | 0410 047 514 · 0410 681 034 · 0410 997 794 |
| Street | **67 Railway Pde** (consistent across all 4 records) |
| **On the record now** | **Campbelltown 2560** |
| Candidates | **Chatswood 2067** ←2 records · Penrith 2750 · Campbelltown 2560 |

**Why first:** the retained suburb is contradicted by every other signal in the org — 2 of
4 in-group records say Chatswood, and the pair partner `Oliver Murphy Residence` says
Chatswood. This is also the 1 of 10 CF-20 flagged as not sharing a suburb. **If any of the
six is wrong, expect it to be this one.**

## 2 🟠 Samuel Fitzgerald — `001gK00001Luv6vQAB`

| | |
|---|---|
| **Ring** | **0410 332 598** · landline **(02) 5218 2302** |
| Fallbacks | 0410 015 838 · 0410 649 358 · 0410 966 118 |
| Street | **23 Beach Rd** |
| **On the record now** | **Chatswood 2067** |
| Candidates | **Penrith 2750** ←2 records · Chatswood 2067 · Campbelltown 2560 |

**Why second:** in-group evidence points away from the retained value (Penrith 2 of 4). The
pair partner agrees with Chatswood, so it is not contradicted outright — but it is the only
support the record has.

## 3 🟡 Lucas Tran — `001gK00001Luv6jQAB`

| | |
|---|---|
| **Ring** | **0410 237 570** · landline **(02) 4870 1930** |
| Fallbacks | 0410 554 330 · 0410 871 090 |
| Street | **111 Sunset Rd** |
| **On the record now** | **Chatswood 2067** |
| Candidates | Chatswood 2067 · Campbelltown 2560 · Penrith 2750 — **one record each** |

**Why third:** the only group of three rather than four, and all three records disagree.
There is no in-group majority to corroborate or contradict — the retained value rests
entirely on record age, with nothing else behind it.

## 4 🟢 Andrew Anderson — `001gK00001Luv8LQAR`

| | |
|---|---|
| **Ring** | **0411 029 470** · landline **(02) 4290 1310** |
| Fallbacks | 0410 079 190 · 0410 395 950 · 0410 712 710 |
| Street | **111 Sunset Rd** |
| **On the record now** | **Campbelltown 2560** ← 2 of 4 records, pair partner agrees |
| Candidates | Campbelltown 2560 · Penrith 2750 · Chatswood 2067 |

## 5 🟢 Daniel Clark — `001gK00001Luv8XQAR`

| | |
|---|---|
| **Ring** | **0411 124 498** · landline **(02) 4638 1682** |
| Fallbacks | 0410 174 218 · 0410 490 978 · 0410 807 738 |
| Street | **23 Beach Rd** |
| **On the record now** | **Campbelltown 2560** ← 2 of 4 records, pair partner agrees |
| Candidates | Campbelltown 2560 · Penrith 2750 · Chatswood 2067 |

## 6 🟢 Joshua Patel — `001gK00001Luv8bQAB`

| | |
|---|---|
| **Ring** | **0411 156 174** · landline **(02) 4754 1806** |
| Fallbacks | 0410 205 894 · 0410 522 654 · 0410 839 414 |
| Street | **67 Railway Pde** |
| **On the record now** | **Penrith 2750** ← 2 of 4 records, pair partner agrees |
| Candidates | Penrith 2750 · Chatswood 2067 · Campbelltown 2560 |

---

## The script

Short, because there is one question and the caller should not be led toward the answer
already on the record.

> *"Hello, is that [name]? It's Hemayet calling from SunRise Solar — nothing's wrong, this
> is a two-minute records check before we book any work at your place.*
>
> *We've tidied up some duplicate customer records this month and I want to make sure we've
> got the right service address for you, so a technician doesn't turn up at the wrong house.*
>
> *Can you confirm the suburb and postcode for me?"*

**Ask open. Do not read the retained suburb out first** — the whole reason this ticket
exists is that a plausible-looking value was accepted without evidence, and prompting them
with it invites a yes.

If they hesitate, offer the candidates as a closed list — *"is it Campbelltown, Chatswood
or Penrith?"* — and record that you prompted.

**Then, same call, for CF-20:**

> *"One more — we've got two records under your name, one on this mobile and one on
> [landline]. Is that both you, or is there another [surname] household we've got mixed in?"*

**And for CF-13, if they mention post going elsewhere:**

> *"And is that the same address you'd want anything posted to?"*

---

## After each call — do these four things

1. **Update `BillingCity` and `BillingPostalCode`** on the account **only if the customer
   named a different suburb.** If they confirm what is there, change nothing.
2. **Clear `Service_Address_Unconfirmed__c`** on that account. This is the control; it is
   what a rep sees before booking a job.
3. **Complete the Task, and write what happened in the Comments** — who you spoke to, what
   they said, and whether you prompted with the candidate list. The Task carries the
   narrative; the checkbox carries the control. **A Task closed without that comment is
   exactly the 29/08 failure repeating**, and the CF-01 report will agree the work is done.
4. **Record the CF-20 answer** against the pair, even if it is *"they didn't know"*.

**If nobody answers:** leave the flag set, leave the Task open, and log the attempt with a
date. **Do not close it as "attempted".** An attempt is not a confirmation, and this ticket
already has a record of six obligations closed to clear a flag.

---

## What to tell Marcus

Per [sop-escalating-rule-changes.md](sop-escalating-rule-changes.md) v1.1 — four things:
what broke, why, what replaced it, and the ask.

| | |
|---|---|
| **To** | Marcus |
| **Channel** | `SunRise Ops — Escalations` — @mention **Marcus Neil** (`005gK00007HBpc5QAD`), the live account. **Not Marcus Head or Marcus Lee, both deactivated.** |
| **Audit copy** | Chatter on `Oliver J. Murphy Residence` |

> *"On the six address confirmations — two things. The discarded addresses turned out to be
> recoverable after all; they're in the 25/08 evidence file, which the CF-02 document said
> twice they weren't. So the calls are now 'is it Campbelltown, Chatswood or Penrith' rather
> than an open question, which makes them quick. Second, those six customers are the same
> six as six of the ten CF-20 pairs, and their Contact groups are CF-13's Bucket B — one
> call each closes all three. That takes the whole customer-contact backlog from about 37
> conversations to about 21, and ten of them close CF-02 and CF-20 outright. I'm making the
> six this week. Oliver Murphy is first — his retained suburb disagrees with every other
> record we hold on him."*

---

## Then the next four

Once the six are done, CF-20 needs four more calls to close completely — the pairs with no
CF-02 flag. All four share a suburb across the pair, so the question is only *"is this one
household or two?"*

| Household | Mobile | Landline | Suburb |
|---|---|---|---|
| William Kowalski | 0410 110 866 | (02) 4406 1434 | Maitland |
| Liam Bennett | 0410 142 542 | (02) 4522 1558 | Wollongong |
| Michael Young | 0410 269 246 | (02) 7306 4534 | Belmont |
| Ryan Singh | 0410 300 922 | (02) 6262 3418 | Wollongong |

**These four are due 08/09 — Tuesday, three working days off.** Doing them in the same
sitting as the six is the cheapest version of this whole backlog, and it is the difference
between CF-20 closing on time and slipping the way CF-01 did.
