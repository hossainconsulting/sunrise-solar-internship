# SOP — User provisioning & deactivation

**SunRise Solar · Owner: Hemayet Hossain · v0.9 (DRAFT — not yet issuable) — 26/08/2026**

**Scope:** creating, verifying, and deactivating internal Salesforce users.

> ### ⚠️ This document is a draft. Do not treat it as the standard.
>
> **Four `✍️ TODO` sections below are unwritten** — §1, §3, §4 and §7. Until they
> are filled in, this SOP cannot be handed to anyone as the way SunRise provisions
> users, because its reasoning is missing in exactly the places that explain *why*
> the steps are in the order they are.
>
> **Version history:**
>
> | Version | Date | Change |
> |---|---|---|
> | v1.0 | 19/08/2026 | First issue — **stamped 1.0 in error, with four sections unwritten** |
> | **v0.9** | **26/08/2026** | **Reversioned down.** A document numbered 1.0 claims to be finished. This one is not, and a reader has no way to tell from the header. Reverting the number is the honest fix; it goes back to 1.0 when the blanks are filled, not before |

> Items marked **✍️ TODO** are deliberately left for the SOP owner to write in
> their own words. An SOP in someone else's voice is not yours to defend.

---

## 1. Pre-flight: confirm a licence FIRST

Before touching `Setup → Users`:

- `Setup → Company Information → User Licenses` → find the row for the licence
  type you need (usually **Salesforce**) and confirm **Remaining ≥ 1**.
- No licence available? **Stop.** Do not improvise. Escalate to the admin lead or
  manager with options: (a) purchase, (b) deactivate an unused account (see §6),
  (c) defer the start date. **Never repurpose an active user's record.**

> ✍️ **TODO — one line, your words:** why this is step 1 and not step 3, referencing
> what happened on 19/08/2026.

## 2. Create the user — in this order

`Setup → Users → New User`. Never clone (see §4).

1. **Licence type** — determines which profiles are even offered.
2. **Profile** — least privilege that does the job (sales reps: Standard User).
3. **Role** — place them in the hierarchy (e.g. Newcastle Sales Team under Sales
   Manager). No user hangs off the top of the tree.
4. **Manager field** — the person they report to. Drives approval routing. Not
   optional, even when nobody asks for it.
5. **Permission sets** — only what is specified in writing. Default: none.

Also set: username on the `firstname.lastname@domain` pattern, timezone
Australia/Sydney, locale en_AU, currency AUD. Leave the password-email checkbox
unticked until their actual start date.

## 3. The Marketing User checkbox

**Marketing User** is a checkbox on the *user record*, not a profile permission.
It gates Campaign create, edit and delete — object permissions can say yes and the
save will still fail if the checkbox is off. It is off by default, including for
System Administrators.

**Policy:** leave it unticked unless the request states the business reason.

> ✍️ **TODO — your words:** why this one is worth calling out in an SOP at all
> (hint: you met it in Phase 0 as `DML operation Delete not allowed on Campaign`).

## 4. Why we never clone users

Cloning copies the source user's accumulated permission sets and record access —
including grants they should never have had. The new hire inherits the mess
silently, nobody notices, and the audit finds it months later attached to someone
who has no idea why they have it. Always build from scratch against the written
spec.

> ✍️ **TODO:** cite the concrete local example (Sarah's note re: Jack's accumulated
> permissions) once you have confirmed the detail.

## 5. Verification — every new user, no exceptions

- `Setup → Users → [user] → Login`. If the link is missing, enable it at
  `Setup → Login Access Policies` ("Administrators Can Log in as Any User").
- Confirm: the correct apps are visible; they can create the records their role
  needs; they **cannot** reach admin or Setup areas.
- Log out of their session and record "verified via Login As" on the ticket.

## 6. Deactivating a user safely

Salesforce blocks deactivation while the user holds system references, and reports
them **one error at a time**. Clear these before you start:

- **Support Settings** — Automated Case User, Default Case Owner
- **Case & Lead assignment rules** — every entry's Assign To / Notify
- **Case escalation rules** — every entry's *action rows*, both fields
- **Web-to-Lead** — default record creator
- **Lead Settings** — Default Lead Owner
- **Process Automation Settings** — Default Workflow User

Reassign each to the admin, or to a queue where a queue is the correct owner.

Three things that cost time on 19/08 and are worth knowing in advance:

1. References held by **inactive** rules still block deactivation.
2. A new error message means the previous reference cleared. Iterate; don't
   conclude it's impossible.
3. In production, **export or document any config before deleting it** to clear a
   reference. Record the deletion in the build log either way.

### Freeze vs. deactivate

**Written in full in [sop-user-deactivation.md](sop-user-deactivation.md) §"Freeze vs.
deactivate" (v1.2, 02/09/2026)** — this TODO always said *"Deliverable for Ticket 1.2,
expand there"*, and it now exists there. The short form:

> **In a contested exit, freeze the same day.** It cuts login access just as immediately
> as deactivation, but leaves the licence, ownership and exit-day record state untouched.
> **Deactivation is the end of offboarding, never the start.**

One rule, one home. Provisioning points at it rather than carrying a second copy that can
drift out of step with the first.

### Order of operations when someone leaves

**Transfer records → freeze → deactivate.** Deactivating an owner first orphans
their records and breaks reports, and unpicking it is tedious.

## 7. Record keeping

Every provisioning and deactivation gets a build-log entry: date, component,
change, reason, verification, follow-ups. Unfinished work gets a written
provisioning record so the next admin can execute it without re-doing the
research.
