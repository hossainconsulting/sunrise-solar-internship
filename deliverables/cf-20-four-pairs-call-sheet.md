# CF-20 — the last four pairs

**SunRise Solar · Org `sunrise` · Drafted 05/09/2026 · Owner: Hemayet Hossain**
**Eight tasks, all Not Started, all due Tuesday 08/09. Monday is the only working day.**

Six of the ten pairs were answered on 03/09 and 05/09 — see
[cf-02-call-list.md](cf-02-call-list.md). These are the four that remain.

---

## These are shorter calls than the six

**Both records in each pair hold an identical address** — same street, same suburb, same
postcode. There is no address to confirm and no `Service_Address_Unconfirmed__c` flag on
any of them. **One question per call.**

| Pair | Address, identical on both records | Ring first (mobile) | Then (landline) |
|---|---|---|---|
| **Kowalski** | 155 Kurrajong Dr, **Maitland 2320** | **0410 110 866** | **(02) 4406 1434** |
| **Bennett** | 199 Mill Lane, **Wollongong 2500** | **0410 142 542** | **(02) 4522 1558** |
| **Young** | 155 Kurrajong Dr, **Belmont 2280** | **0410 269 246** | **(02) 7306 4534** |
| **Singh** | 199 Mill Lane, **Wollongong 2500** | **0410 300 922** | **(02) 6262 3418** |

### Record ids

| Pair | Account (mobile / `J.`) | Account (landline) | Task (`J.`) | Task (landline) |
|---|---|---|---|---|
| Kowalski | `001gK00001Luv6TQAR` | `001gK00001Luv43QAB` | `00TgK00000BTRUkUAP` | `00TgK00000BTRUjUAP` |
| Bennett | `001gK00001Luv6XQAR` | `001gK00001Luv47QAB` | `00TgK00000BTRUmUAP` | `00TgK00000BTRUlUAP` |
| Young | `001gK00001Luv6nQAB` | `001gK00001Luv5fQAB` | `00TgK00000BTRUqUAP` | `00TgK00000BTRUpUAP` |
| Singh | `001gK00001Luv6rQAB` | `001gK00001Luv55QAB` | `00TgK00000BTRUsUAP` | `00TgK00000BTRUrUAP` |

---

## ⚠️ Read this before you ring — the evidence in these tasks is now known to be wrong

All eight tasks carry the same sentence:

> *"EVIDENCE they are one household: matching suburb, and complementary phone formats -
> landline on one record, mobile on the other - consistent with two import sources for the
> same customer. That pattern holds on all 10 pairs."*

**That hypothesis has now been tested six times and failed six times.** Murphy, Fitzgerald,
Tran, Anderson, Clark and Patel all carried exactly that pattern, and all six customers
said the two records are **separate households**.

**So the stated evidence is 0 for 6 as a predictor.** It is still in the task text, and it
should not be read on Monday as though it points anywhere.

> **This does not mean these four are separate.** Six results are not a rule, and assuming
> the answer from a run of six is the same error as assuming it from a phone-format
> pattern — which is the error CF-20 exists to prevent. **Ask. Do not infer.**
>
> What it does mean: expect *separate*, be unsurprised by *same*, and do not let the
> sentence in the task nudge the question.

---

## The call

One question, asked plainly. Ring the mobile; if there is no answer, ring the landline —
**getting the same person on both numbers is itself most of the answer.**

> *"Hello, is that [name]? It's Hemayet from SunRise Solar — nothing's wrong, this is a
> two-minute records check. We've got two customer records under your name at
> [address] — one on this number and one on [other number]. Are they both you, or is there
> another [surname] household at that address we've got mixed in with yours?"*

If they say both are theirs, one useful follow-up: *"Which number should we use to reach
you about a job?"* — that is the number worth keeping on the surviving record.

**Do not merge anything on the call.** The answer is the input to the merge decision, not
the authority for it — CF-13's survivorship rule went to Marcus before anything
irreversible happened, and this is the same shape.

---

## Recording it — fill these in, do not paste both options

For each pair, write the answer onto **both** tasks, then set both to Completed.

**If one household:**
```
--- Answered 0X/09/2026 ---
Rang [number], spoke to [name]. Confirms both records are HIS/HER household -
one customer, two records from the 17/08 load. Preferred contact number: [number].
MERGE CANDIDATE. Not merged on this call: survivorship goes to Marcus first.
Consequence for CF-01: this pair reduces the customer count by one.
```

**If two households:**
```
--- Answered 0X/09/2026 ---
Rang [number], spoke to [name]. The two records are NOT the same household -
two separate customers at the same address. DO NOT MERGE this pair.
Consequence for CF-01: this pair contributes no reduction to the customer count.
```

**If nobody answers:** log a dated attempt, leave both tasks `Not Started`, and say so to
Marcus. **Do not close them as attempted** — that is the 29/08 failure, and it has already
recurred once on CF-02.

> **Every defect in CF-02 since 03/09 entered through this field by hand** — a paste landing
> mid-line, a wrong surname, a mangled em dash, and both alternatives of a worked example
> pasted in so each line asserted its own opposite. **Type these. Do not paste a template
> and edit it.** If you would rather, send me the four answers and it goes in by script.

---

## What each answer is worth

The customer count is **51 accounts**. Each pair confirmed *one household* reduces it by
one; each *two households* leaves it alone.

| Outcome on the four | Customer count |
|---|---|
| All four separate | **51** |
| Three separate, one merges | 50 |
| Two and two | 49 |
| One separate, three merge | 48 |
| All four merge | **47** |

**The range is 47–51 and these four calls close it to a single number.** That is the number
Marcus asked for on 25/08 and has never had — and the reason CF-01's freeze point exists.

**Marcus published 41–51 to Sarah on 02/09.** The bottom of that range is now unreachable:
it required all ten pairs to be duplicates, and six are not. See
[status-note-marcus-cf-01-range-revision.md](status-note-marcus-cf-01-range-revision.md).
