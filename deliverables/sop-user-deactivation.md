# SOP — Deactivating a departing user

**SunRise Solar · Owner: Hemayet Hossain · v1.1 — 26/08/2026**

**Scope:** removing access when someone leaves, without orphaning their records
or stranding their licence. Companion to [sop-user-provisioning.md](sop-user-provisioning.md).

**Golden rule: freeze → transfer → deactivate. In that order, every time.**

**Second rule, added in v1.1: nobody is deactivated until the owned-records gate
reads CLEAR.** Not "I checked the obvious objects" — CLEAR, from the script in
[Step 1](#step-1--run-the-owned-records-gate).

> **v1.1 — why this changed.** This SOP was written on 19/08 listing four things to
> check: Accounts, Opportunities, Cases, open Leads. That is the list for a departing
> **sales rep**. On the same day, Ticket 1.1 deactivated the **OrgFarm EPIC** system
> account to recover a licence, and nobody ran this SOP against it — it did not look
> like a person leaving.
>
> Measured on 26/08, seven days later, that deactivated user still owns:
>
> | Object | Records | Notes |
> |---|---|---|
> | Opportunity | **224** | **38 still open, worth $481,280** — 25% of the entire open pipeline, owned by a disabled user and still in the forecast |
> | EmailTemplate | 13 | |
> | Solution | 10 | |
> | **Total** | **247** | |
>
> Two of those three object types are not on the v1.0 list and never would have been.
> **A hand-written list of objects only catches the records you already thought of.**
> v1.1 replaces the list with a script that asks the org.

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

- [ ] What do they own — **per the gate in Step 1, not per memory**? Who inherits?
- [ ] Are they mid-approval on anything? (An approval sitting with a deactivated
      user stalls silently.)
- [ ] Are they in Default Account Teams, Opportunity Teams, or a queue?
- [ ] Is this a clean exit or a contested one? Determines freeze-only vs. full
      deactivation.
- [ ] Is anything scheduled or owned by them in automation — Default Workflow
      User, scheduled jobs, email alerts, dashboard running user?

## Step 1 — Run the owned-records gate

**Do not hand-write a list of objects to check.** Run
[`seed/check-owned-records.apex`](../seed/check-owned-records.apex) in
`Developer Console → Debug → Open Execute Anonymous Window` (tick **Open Log**).

Set `TARGET_USER` to the person's full name, run it, and read the debug log. It walks
**every queryable object in the org that carries an `OwnerId`** — 144 of them in this
org — and reports anything the user still holds.

### It will take more than one run, and that is not optional

Apex allows 100 SOQL queries per transaction and there are 144 objects to count. **One
pass physically cannot cover them all.** The script counts as far as it safely can,
then prints:

```
*** INCOMPLETE — hit the SOQL ceiling. ***
*** Re-run with SKIP = 89 to cover the rest. ***
```

Set `SKIP` to that number, run it again, and **add the two slices together**. It says
`Scan complete` only when it has reached the end of the object list.

> **If you only ever run it once, you have not run the gate — you have run part of
> it.** In this org the first slice returns EmailTemplate only; Opportunity does not
> appear until the second. Stopping at slice one would have shown a near-clean user
> holding 224 Opportunities.

### Record the totals before you transfer

Paste the combined result into the ticket and the build log. That is your evidence
the transfer was complete — and the only thing that lets you prove it later.

### The gate is also the answer to "is this even a person?"

Run it against **system and integration accounts too**, not just leavers. OrgFarm EPIC
was not a departing employee, which is exactly why nobody thought to run this SOP
against it. Ownership does not care whether the account belongs to a human.

For sweeping several accounts at once, use
[`seed/sweep-owned-records.apex`](../seed/sweep-owned-records.apex) — same gate, one
grouped query per object instead of one per object per user.

> **Swept 26/08/2026.** All seven service accounts came back clean — one stock
> EmailTemplate between them. **The two never-logged-in staff accounts did not:
> Jack Nguyen and Mia Kelly own 221 Opportunities each, $939,904 of open pipeline
> between them.** "Has never logged in" is not the same as "owns nothing", and a
> dormant-user review that assumes otherwise is the exact trap this gate exists to
> catch.

### Deactivation is not the only action this gate governs

**A licence-type change needs it too.** Converting a user to a Platform licence does
not move their records — but Platform licences have no access to `Opportunity` or
`Campaign` at all (no `ObjectPermissions` row exists, so no permission set can grant
it). The user keeps owning records they can no longer open.

Run the gate before **any** change to what a user is, not just before switching them
off.

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

## Step 4 — Re-run the gate. It must read CLEAR.

Run Step 1 again — **all slices, to `Scan complete`**. Every count must be **0**.

If anything remains, you missed an object type. That is the gate doing its job: the
objects you miss are by definition the ones you did not think of, which is why the
script enumerates them instead of you.

Do not skip this. The whole point of the order of operations is that you can prove it
worked.

## Step 5 — Deactivate

> ### 🚦 Hard gate
>
> **Do not open this screen until Step 4 printed `CLEAR — safe to deactivate` across
> every slice.**
>
> Deactivating with records still owned does not fail, warn, or prompt. It succeeds
> silently and leaves the records behind — where they stay in reports and forecasts,
> owned by someone who cannot be assigned work, cannot be emailed, and cannot action
> anything. There is no error to catch later. **The gate is the only thing standing
> between you and that outcome**, and it costs two minutes.

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

### This is not hypothetical — it happened here

**OrgFarm EPIC, 19/08/2026.** Deactivated to recover a Salesforce licence. Every
system *reference* was patiently cleared first — Case settings, lead assignment
rules, escalation rules, Web-to-Lead, the Default Workflow User — because Salesforce
*refuses to deactivate* while those exist. Six blockers, one at a time. It felt
thorough.

**Salesforce never once mentioned record ownership, because record ownership does not
block deactivation.** Seven days later that user still owned 224 Opportunities,
13 EmailTemplates and 10 Solutions — 38 of the Opportunities open, worth $481,280,
sitting in the forecast Jake was asked to produce in Ticket 2.3.

**The lesson is the shape of the failure, not the number.** The org enforces the
things that would break *it*, and is silent about the things that break *your data*.
Anything Salesforce blocks you on, you will find. Anything it does not, you only find
if you go looking — which is what Step 1 is for.

Full write-up: [ticket-2.3-pipeline-hygiene-report.md](ticket-2.3-pipeline-hygiene-report.md) §④.
