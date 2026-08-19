# Ticket 1.1 — remediation steps (org work)

**For:** Hemayet · **Date:** 19/08/2026 · **Est. 45–60 min total**

Everything Marcus's review threw up that can only be fixed _in the org_. Written
click-by-click. Do them in order — Task 1 is the one that matters.

**Getting to Setup, every time:** click the **gear icon** top-right of any
Salesforce page, then **Setup**. Setup opens in a new tab. The **Quick Find** box
is top-left of the Setup sidebar — type there rather than hunting through menus.

---

## Task 0 — Evidence first (5 min)

The brief asks for a screenshot **before you change anything**. You're past that
for the original licence page, but capture the current state before this round.

1. Setup → Quick Find: `Company Information`. Scroll to **User Licenses**. Screenshot.
2. Setup → Quick Find: `Users` → **Users**. Screenshot the list.
3. Click **Ben Carter** → screenshot his record showing the blank Role and Manager.
   This is your "before" for Task 1 — you want proof you found it and fixed it.

**Windows:** press `Win + Shift + S`, drag a box. It goes to your clipboard and to
`Pictures/Screenshots`.

Save them into `evidence/week-01/`, named like `01-licences-before.png`,
`02-ben-carter-before.png`.

---

## Task 1 — Fix Ben Carter's record (10 min)

**Why:** your own SOP §2 says every user gets a Role and a Manager. Ben has
neither. This is the finding that undermines the whole document.

### 1a. Create the role Ben belongs in

Your org has the **18 default Salesforce sample roles** (CEO → SVPs → VPs →
Directors → teams). It is a generic US company structure — nobody has ever built
SunRise's real hierarchy. You are **not** fixing that today. You are adding the
one role you need and writing down that the rest is sample data.

1. Setup → Quick Find: `Roles` → click **Roles**.
2. If you get an "Understanding Roles" explainer page, click **Set Up Roles**.
3. You'll see the tree with **CEO** at the top. Find **Director, Direct Sales**
   (it sits under _VP, North American Sales_). It already has two children:
   _Eastern Sales Team_ and _Western Sales Team_.
4. Click **Add Role** underneath _Director, Direct Sales_.
   If the tree view is fiddly, switch to the list view via the link at the top,
   use the **New Role** button, and set the parent manually.
5. Fill in:
   - **Label:** `Newcastle Sales Team`
   - **Role Name** auto-fills — leave it
   - **This role reports to:** `Director, Direct Sales`
   - **Role Name as displayed on reports:** `Newcastle Sales`
6. **Save.**

> **Why under _Director, Direct Sales_?** Because that is where the other two
> sales team roles already sit, so Ben's records roll up the same way theirs
> would. You are matching the existing shape rather than inventing a parallel one.
> Say exactly that if Marcus asks.

### 1b. Give him the Role, a Manager, and a Title

1. Setup → Quick Find: `Users` → **Users**.
2. Click **Ben Carter** (the name, not Edit).
3. Click **Edit**.
4. Set:
   - **Role:** `Newcastle Sales Team`
   - **Manager:** `Hemayet Hossain` — click the magnifying glass and search
   - **Title:** `Sales Representative`
5. Leave everything else alone. **Save.**

> **Why you as Manager?** Because Jack Nguyen and Mia Kelly already have you as
> their Manager, and Marcus and Jake do not exist as users in this org.
> Consistency beats invented accuracy — but **write the follow-up down**: _"Manager
> set to admin as placeholder; reassign when the real reporting line exists as
> users."_

### 1c. The bit you'll be tempted to skip

Jack and Mia are also Sales Representatives with **no Role**. If Ben has one and
they don't, you have created a new inconsistency while fixing the old one.

You don't know which office Jack and Mia are in — so **don't guess**. Add a
follow-up instead: _"Jack Nguyen and Mia Kelly have no role assigned. Awaiting
confirmation of their office before placing them in the hierarchy."_

Knowing that you don't know, and saying so, is the right answer here.

---

## Task 2 — Enable Login As, then actually verify Ben (10 min)

**Why:** your status note claims "verified via Login As". Your build log says that
is unconfirmed. Make one of them true.

### 2a. Turn the feature on (once, ever)

1. Setup → Quick Find: `Login Access Policies`.
2. Tick **Administrators Can Log in as Any User**.
3. **Save.**

### 2b. Log in as Ben

1. Setup → Quick Find: `Users` → **Users**.
2. In Ben Carter's row, click the **Login** link on the left.
   No Login link? The row actions are in the leftmost column — you may need to
   scroll the list sideways. If it is still missing, step 2a did not save.
3. You are now looking at Salesforce **as Ben**. A banner across the top says so.

**Check these and write down what you see:**

- [ Y] Which apps can he reach? (App Launcher — the grid icon, top left)
- [Y ] Can he see **Opportunities**? Open the tab, open a record.
- [ Y] Can he **create** an Opportunity? Open the New form — you can cancel it.
- [ Y] Can he reach **Setup**? He should **not** be able to. The gear menu should
  have no Setup option.
- [Y ] Can he edit a **Campaign**? He should not — his Marketing User checkbox is
  off. This is exactly what Zara's YTicket 1.3 is about, so you get a free
  look at it here.

4. Click **Log out** in the banner at the top to return to your own session.

> **Novice trap:** "Log out" in that banner returns you to _your_ admin session.
> It does not log you out of Salesforce entirely. That is what you want.

---

## Task 3 — Find out what actually happened to the rules (15 min)

**Why:** I queried the org. What is there does not match your write-up, and you
want to know that before Marcus does.

**What the org shows right now:**

| Thing                                       | Your write-up says                         | The org says                                                         |
| ------------------------------------------- | ------------------------------------------ | -------------------------------------------------------------------- |
| Lead assignment rule "Standard"             | Reassigned to H. Hossain                   | ✅ **Matches.** Still there, active, 2 entries, both pointing at you |
| Case assignment rule "Standard" (5 entries) | Reassigned to H. Hossain                   | ⚠️ **Gone.** There are no case assignment rules at all               |
| Case escalation rule "Standard" (8 entries) | Reassigned — and a later note says deleted | ⚠️ **Gone.** There are no case escalation rules at all               |
| Web-to-Lead config                          | Deleted                                    | ❓ Not checked — see 3c                                              |

So it looks like you **deleted** the two Case rules rather than reassigning them.
That may well have been the right call. But it is not what your document says, and
"I reassigned it" versus "I deleted it" is a meaningful difference to whoever
reads this next.

### 3a. Confirm the case assignment rules are gone

Setup → Quick Find: `Case Assignment Rules`. Expect an empty list.

- I deleted it

### 3b. Confirm the case escalation rules are gone

Setup → Quick Find: `Escalation Rules`. Expect empty.

- I deleted it

### 3c. Check Web-to-Lead

Setup → Quick Find: `Web-to-Lead`.

- I deleted it
- Note who the **Default Lead Creator** is now. Default Lead Creator: Hemayet Hossain
- Note whether Web-to-Lead is **enabled**.
- Screenshot either way.

### 3d. Confirm the reassignments actually stuck

Each of these is about 30 seconds, and they are the ones that would quietly point
somewhere odd:

1. Setup → Quick Find: `Support Settings` — **Automated Case User** and **Default
   Case Owner** should both be Hemayet Hossain.
2. Setup → Quick Find: `Lead Settings` — **Default Lead Owner**. - Default Lead Owner Hemayet Hossain
3. Setup → Quick Find: `Process Automation Settings` — **Default Workflow User**. -Hemayet Hossain

Screenshot each.

**Then tell me what you found** and I will correct the build log and the licence
recovery write-up to match, replacing my ⚠️ flag with the real answer.

---

## Task 4 — Re-check the licence position (2 min)

Setup → Quick Find: `Company Information` → **User Licenses**.

Confirm: **Salesforce 4 of 4 used**, **Salesforce Platform 0 of 6 used**.

Screenshot. This is the number your status note to Marcus depends on, and it is
what makes the Platform-licence option real rather than theoretical.

---

## Task 5 — Evidence and hand back (5 min)

1. All screenshots into `evidence/week-01/`.
2. Come back to me with:
   - What you found in Task 3
   - What you saw during the Login As in Task 2
   - Confirmation that Task 1 saved

I will then update `build-log.md`, `ticket-1.1-licence-recovery.md` and the status
note so the documents match the org.

---

## What you are NOT doing today

Worth being explicit, because the novice instinct is to fix everything at once:

- **Not** rebuilding the role hierarchy. One role, matching the existing shape.
  The rest is a Week 2+ design conversation.
- **Not** placing Jack and Mia in roles. You don't know their offices. Ask.
- **Not** deactivating Jack or Mia. Marcus hasn't answered, and the better option
  is a licence downgrade, not a deactivation.
- **Not** recreating the deleted case rules. Nothing is using them. Record what
  happened and move on.
