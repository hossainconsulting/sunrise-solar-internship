# SOP — Deactivating a departing user

**SunRise Solar · Owner: Hemayet Hossain · v1.0 — 19/08/2026**

**Scope:** removing access when someone leaves, without orphaning their records
or stranding their licence. Companion to [sop-user-provisioning.md](sop-user-provisioning.md).

**Golden rule: freeze → transfer → deactivate. In that order, every time.**

> An earlier draft of this SOP said *transfer → freeze → deactivate*, which
> contradicted its own numbered steps below. Freeze comes first, and the reason is
> that the two actions answer different questions. **Freeze is a security decision
> and it is urgent** — it stops login within seconds, costs nothing, and is
> reversible. **Transfer is a data decision and it is not urgent** — it can take
> days if you have to chase who inherits what. Doing the slow one first leaves a
> departed employee able to log in for the duration.
>
> What must never happen is **deactivating before transferring**, which orphans
> their records. Both orderings protect against that; only one also closes access
> immediately.

---

## Freeze vs. deactivate — read this before you touch anything

> ✍️ **TODO — write this paragraph in your own words. It is the part of this SOP
> that shows whether you understand access management or just know where the
> buttons are.** Cover, at minimum:
>
> - **Freeze** blocks login immediately and is instant and reversible. It does
>   **not** release the licence and does **not** affect record ownership.
> - **Deactivate** releases the licence, but the user's record ownership, queue
>   membership and approval steps have to be dealt with first.
> - Therefore: **freeze the moment access should stop** (that's a security
>   decision, and it's cheap), then deactivate once the record cleanup is done
>   (that's a licence decision, and it's not urgent).
> - Contested exit, legal or HR still deciding, possible reinstatement, or an
>   investigation? **Freeze and stop there.** Deactivating destroys the tidy
>   picture of what they owned at the moment they left, and reversing it is not a
>   clean undo.

---

## Pre-flight — ask, don't assume

- [ ] What do they own — Accounts, Opportunities, Cases, open Leads? Who inherits?
- [ ] Are they mid-approval on anything? (An approval sitting with a deactivated
      user stalls silently.)
- [ ] Are they in Default Account Teams, Opportunity Teams, or a queue?
- [ ] Is this a clean exit or a contested one? Determines freeze-only vs. full
      deactivation.
- [ ] Is anything scheduled or owned by them in automation — Default Workflow
      User, scheduled jobs, email alerts, dashboard running user?

## Step 1 — Find out what they own

`Developer Console → Debug → Open Execute Anonymous Window`:

```apex
Id u = [SELECT Id FROM User WHERE Name = 'Alan Brooks' LIMIT 1].Id;
System.debug('Accounts:      ' + [SELECT COUNT() FROM Account     WHERE OwnerId = :u]);
System.debug('Opportunities: ' + [SELECT COUNT() FROM Opportunity WHERE OwnerId = :u]);
System.debug('Cases:         ' + [SELECT COUNT() FROM Case        WHERE OwnerId = :u]);
System.debug('Open Leads:    ' + [SELECT COUNT() FROM Lead        WHERE OwnerId = :u AND IsConverted = false]);
```

Faster from the CLI, and it gives you something you can paste into the ticket:

```bash
sf data query --target-org sunrise --result-format csv \
  -q "SELECT Owner.Name, COUNT(Id) FROM Account WHERE Owner.Name = 'Alan Brooks' GROUP BY Owner.Name"
```

Record the counts **before** you transfer. That's your evidence the transfer was
complete.

## Step 2 — Freeze

`Setup → Users → [user] → Freeze`. Do this as soon as access should stop, even if
the record cleanup will take days. Login is blocked from this moment; the licence
is untouched.

## Step 3 — Transfer the records

`Setup → Mass Transfer Records` — one object type at a time (Accounts, Leads).
Opportunities and Cases follow Account ownership only if you tell them to; check
the "transfer related" options rather than assuming.

Not covered by Mass Transfer, so handle by hand:
- [ ] Open approval requests — reassign or recall
- [ ] Reports and dashboards where they are the running user
- [ ] Account / Opportunity team memberships
- [ ] Queue memberships
- [ ] Anything in [sop-user-provisioning.md §6](sop-user-provisioning.md) — the
      system-reference list. A departing rep is less likely to hold those than a
      system account, but check rather than discover.

## Step 4 — Re-run Step 1

Every count should be **0**. If it isn't, you missed an object type. Do not skip
this; the whole point of the order of operations is that you can prove it worked.

## Step 5 — Deactivate

`Setup → Users → [user] → Edit → untick Active`.

Salesforce reports remaining blockers **one at a time**. A new error message means
the previous reference cleared — iterate, don't conclude it's impossible.
References held by **inactive** rules still block.

## Step 6 — Verify and record

- [ ] `Setup → Company Information → User Licenses` — the licence count actually
      dropped. Deactivated ≠ licence recovered until you've looked.
- [ ] The user cannot log in.
- [ ] Build-log entry: date, user, what they owned, where it went, who authorised
      the exit, verification result.

## What goes wrong when you skip the order

Deactivate first and the records are orphaned: reports break, pipeline forecasts
lose their owner, and Mass Transfer no longer offers the user as a source in every
screen. Unpicking it means reactivating (which needs a free licence you may no
longer have), transferring, and deactivating again.

Transfer first and none of that happens.
