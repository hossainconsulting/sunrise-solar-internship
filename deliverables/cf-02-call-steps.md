# CF-02 — Call 1 of 6: Oliver Murphy, click by click

**SunRise Solar · Org `sunrise` (`orgfarm-ebdb5a0e5f-dev-ed`) · Written 03/09/2026**
**Do this one first.** Order and reasoning: [cf-02-call-list.md](cf-02-call-list.md).

| | |
|---|---|
| **Account** | `Oliver J. Murphy Residence` · `001gK00001Luv6zQAB` |
| **Task** | `00TgK00000BTQVWUA5` · Not Started, High, no due date |
| **Pair partner** (CF-20) | `Oliver Murphy Residence` · `001gK00001Luv3vQAB` |
| **Ring** | **0410 364 274**, then landline **(02) 4174 1186** |
| **On the record** | 67 Railway Pde, **Campbelltown 2560** |
| **Candidates** | **Chatswood 2067** ←2 records · Penrith 2750 · Campbelltown 2560 |

---

## Before you dial — 2 minutes

**1.** Open the account:
`https://orgfarm-ebdb5a0e5f-dev-ed.develop.my.salesforce.com/lightning/r/Account/001gK00001Luv6zQAB/view`

**2.** Confirm **Service Address Unconfirmed** is ticked — third field, directly under
Account Name. If it is not ticked, stop: someone has cleared it and you need to know who
and why before ringing. Check **Related → History** or the field's audit trail first.

**3.** Have the three candidate suburbs in front of you: **Campbelltown, Chatswood,
Penrith.** Do not read them out unless the customer hesitates.

---

## The call

> *"Hello, is that Oliver Murphy? It's Hemayet from SunRise Solar — nothing's wrong, this
> is a two-minute records check before we book any work at your place. We've tidied up some
> duplicate customer records this month and I want to make sure we've got the right service
> address, so a technician doesn't turn up at the wrong house. **Can you confirm the suburb
> and postcode for me?**"*

**Ask open.** Do not say "we've got you at Campbelltown, is that right?" — the reason this
ticket exists is that a plausible value was accepted without evidence, and prompting invites
a yes. Only if they hesitate: *"is it Campbelltown, Chatswood or Penrith?"* — and record
that you prompted.

**Then, same call, for CF-20:**

> *"One more — we've got two records under your name, one on this mobile and one on
> (02) 4174 1186. Is that both you, or is there another Murphy household we've got mixed in?"*

---

## After the call — one edit, one save

### A · If they name a different suburb (expect this one — the evidence points at Chatswood)

**4.** On the account, click the **pencil** on any field. This opens the whole record for
inline edit — you are changing three things in **one save**, not three.

**5.** In **Billing Address**, set **City** and **Zip/Postal Code** to what they said.
Leave **Street** alone — `67 Railway Pde` is consistent across all four merged records and
was never in question.

**6.** Untick **Service Address Unconfirmed**.

**7.** **Save.**

### B · If they confirm Campbelltown

**4.** Click the pencil, untick **Service Address Unconfirmed** only. **Change nothing
else** — a confirmed value needs no edit, and touching the address moves `LastModifiedDate`
for no reason.

**5.** **Save.**

---

## Then the Task — and this is the step that failed on 29/08

**8.** Open the task:
`https://orgfarm-ebdb5a0e5f-dev-ed.develop.my.salesforce.com/lightning/r/Task/00TgK00000BTQVWUA5/view`

**9.** Click the pencil on **Comments**. **Append** to what is there — do not overwrite it.
The existing text records why the address was unconfirmed and is the narrative:

```
03/09/2026 — Rang 0410 364 274, spoke to Oliver Murphy.
Confirmed service address as: 67 Railway Pde, <SUBURB> <POSTCODE>.
Asked open; did / did not prompt with the candidate list.
Account updated, Service_Address_Unconfirmed__c cleared.
CF-20: customer says the two Murphy records are / are not the same household.
```

**10.** In the **same edit**, set **Status = Completed**.

**11.** **Save.**

> ### Why 9 and 10 are one save
>
> On 29/08 all six of these tasks were set to Completed with the original comment still
> reading *"Service address on this account was NOT confirmed with the customer."* The org
> held six completed tasks whose own text said the work had not been done, and the CF-01
> report agreed the problem was gone. **Writing the comment and closing the task in one
> save means that state cannot exist**, even for a minute.

---

## If nobody answers

**12.** Add a dated line to **Comments** — *"03/09 14:20 — no answer on mobile, no answer on
landline, no voicemail left / voicemail left."*

**13.** **Leave Status at Not Started. Leave the checkbox ticked. Save.**

**Do not close it as "attempted".** An attempt is not a confirmation. This ticket already
has a record of six obligations closed to clear a flag, and that is the whole reason the
control moved off the task and onto the account.

---

## CF-20 — capture the answer while you have it

**14.** The twenty CF-20 tasks are due 08/09 and two of them are Murphy's. Find them in the
report `CF-01 Open tasks by due date`:
`https://orgfarm-ebdb5a0e5f-dev-ed.develop.my.salesforce.com/lightning/r/Report/00OgK00000DlqOfUAJ/view`
— group **08/09/2026**, look for the two Murphy rows.

**15.** Put the customer's answer in the Comments of both, dated. **Do not merge the pair
today**, whatever they said. The merge needs the survivorship question settled the way
CF-13's did, and a phone answer recorded is the input to that, not the authority for it.

---

## Audit copy — Chatter

**16.** Back on the account, **Chatter** tab → post:

> *"03/09 — rang Oliver Murphy, confirmed service address as 67 Railway Pde, <SUBURB>.
> Flag cleared, task closed with the detail. CF-20: he says the two Murphy records are /
> are not the same household."*

Record post is the audit copy; per [sop-escalating-rule-changes.md](sop-escalating-rule-changes.md)
v1.1 the recipient copy goes to `SunRise Ops — Escalations` @mentioning **Marcus Neil**
(`005gK00007HBpc5QAD`) — **not Marcus Head or Marcus Lee, both deactivated.** Send Marcus
one summary after all six, not six posts.

---

## Then repeat for the other five

Same eleven steps. Order is by contradiction, not alphabet.

| # | Household | Account | Task | Ring | On record |
|---|---|---|---|---|---|
| 2 | Samuel Fitzgerald | `001gK00001Luv6vQAB` | `00TgK00000BTQVVUA5` | 0410 332 598 / (02) 5218 2302 | Chatswood 2067 |
| 3 | Lucas Tran | `001gK00001Luv6jQAB` | `00TgK00000BTQVUUA5` | 0410 237 570 / (02) 4870 1930 | Chatswood 2067 |
| 4 | Andrew Anderson | `001gK00001Luv8LQAR` | `00TgK00000BTQVRUA5` | 0411 029 470 / (02) 4290 1310 | Campbelltown 2560 |
| 5 | Daniel Clark | `001gK00001Luv8XQAR` | `00TgK00000BTQVSUA5` | 0411 124 498 / (02) 4638 1682 | Campbelltown 2560 |
| 6 | Joshua Patel | `001gK00001Luv8bQAB` | `00TgK00000BTQVTUA5` | 0411 156 174 / (02) 4754 1806 | Penrith 2750 |

Streets, by household: Fitzgerald `23 Beach Rd` · Tran `111 Sunset Rd` · Anderson
`111 Sunset Rd` · Clark `23 Beach Rd` · Patel `67 Railway Pde`. **All candidates are the
same three suburbs every time** — Campbelltown 2560, Chatswood 2067, Penrith 2750.

---

## When all six are done

**17.** Reload the report — the six should have left the open list.
**18.** Check the flag is clear on all six: **Accounts → filter `Service Address
Unconfirmed = True`.** It should return **zero**. If it returns six, the saves did not take.
**19.** Update [carry-forward-tickets.md](carry-forward-tickets.md) CF-02 to the real count,
and [cf-02-address-confirmations.md](cf-02-address-confirmations.md) — which still says the
discarded addresses are unrecoverable, and still says 0 of 6.
