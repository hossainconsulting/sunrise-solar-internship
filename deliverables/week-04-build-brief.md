# Week 4 — $180,000 of campaigns and nobody rang anybody

**Org:** `sunrise` · **~6–8 hours** · **3 tickets** · **3 deliverables**
**Written 07/09/2026. Every figure below was queried from the org this morning, not
carried forward from a document.**

Week 2 was the data. Week 3 was the debt that data created. **Week 4 is the money.**

SunRise spent **$180,000** on six marketing campaigns that finished on 30 June. They
generated **150 leads**. Every one of those 150 leads is still `Open - Not Contacted`,
**sixty-nine days later**, and all 150 are owned by the system administrator.

**Nobody has rung a single one of them.**

Nothing this week is hard to click either. The difficulty is that Marcus is going to ask
*"which campaign should we run again?"* — and the honest answer is that **this org cannot
tell him, and the reason has nothing to do with marketing.**

**Before you build anything, write your clarifying questions down.** Then compare them to
the ones listed here.

---

## Carried forward from Week 3

Do not start Week 4 pretending these closed:

- **The three Salesforce licences Marcus approved on 01/09 have not arrived.** Six days.
  The org still reads **4 of 4**. **This is now on the critical path rather than beside
  it:** Week 4 is campaigns, **Priya Sharma is on a Standard Platform licence, and a
  Platform licence has no Campaign object at all** (CF-18, verified in Ticket 1.3). The one
  person whose job this week describes cannot open the object this week is about.
- **Three decisions sit with Marcus** — the three CF-20 merges, CF-13 Bucket B, and the
  licences. **Fallback is Friday 11/09.** Do not chase before then; the fallback exists so
  the work proceeds without him.
- **The `CF-02 · Address confirmations` list view is still private.** Nine days. It is ten
  minutes, and it is cheapest to fix now precisely because the list is empty.
- **Four `✍️ TODO` markers, untouched since 03/09** — three in
  [sop-user-provisioning.md](sop-user-provisioning.md) (still honestly v0.9 DRAFT) and one
  in [dormant-user-review.md](dormant-user-review.md). **Nobody is blocking these.**
- **CF-12, CF-15, CF-16** — ready, unstarted. CF-12 becomes relevant this week: lead
  assignment needs a role hierarchy that means something, and CF-15 says the org's is
  Salesforce's US demo sample.

---

## ⚠️ Read this before Ticket 4.2 — the bug you were going to diagnose does not exist

**Phase 0 §0.8 says: *"Build these now and forget how. In Weeks 4, 5 and 10 you diagnose
them cold."* Verified in the org today: none of the three were ever built.**

| Phase 0 bug | For | In the org today |
|---|---|---|
| Web-to-Lead form, inactive auto-response, deleted State field | **Week 4.2** | ❌ **Absent.** No `seed/webform.html`. All 150 leads have a State |
| `NSW Territory Routing` assignment rule, entry order bug | Week 5.1 | ❌ **Absent.** Only the stock `Standard` rule exists |
| Over-permissioned user + `Legacy Reporting Access` perm set | Week 10.1 | ❌ **Absent.** No such permission set; no non-admin holds View All Data |

**And the Week 4.2 one was not merely skipped — it was deliberately deleted.** From the
build log, **19/08/2026**, during Ticket 1.1's licence recovery:

> *"Removed the unused Web-to-Lead config referencing OrgFarm EPIC… Training artifact, no
> live lead capture. Accepted risk, noted."*

**Every word of that is true and it removed the subject of Week 4.2.** The config genuinely
was unused, it genuinely was blocking EPIC's deactivation, and deleting it was genuinely
the right call for Ticket 1.1. **It was recorded correctly and connected to nothing** —
which is CF-22's shape exactly: *a finding recorded against one ticket does not propagate
to the others.* Third occurrence, and the first where the cost landed on future work
rather than past.

### What to do about it — decide before 4.2, do not improvise mid-ticket

**You cannot plant a bug and diagnose it cold in the same week.** That exercise is gone;
pretending otherwise produces a fake investigation with a known answer, which teaches the
opposite of what Week 4.2 was for.

**Recommended:**

- **Week 4.2 becomes a build, not a diagnosis.** Build Web-to-Lead **correctly** — form,
  an **active** auto-response rule, complete field set — and write up what each piece
  prevents. You lose the cold diagnosis; you gain live lead capture the org does not have,
  and a design document that names the three failure modes rather than staging them.
- **Plant the Week 5.1 and Week 10.1 bugs today, in five minutes, and do not write down
  how.** Both are still genuinely recoverable: Week 5 is a week away and Week 10 is six.
  Cold diagnosis survives if the gap is real. **Do this first, before 4.1** — if it waits
  until Week 5 opens, it is gone the same way this one went.

---

## Ticket 4.1 — "Which campaign should we run again?"

**Marcus, Monday morning.** Budget planning for FY27 Q1 starts this week and he wants to
put the $180,000 somewhere better.

### What's actually in there

| Campaign | Type | Budgeted | **Actual** | Leads |
|---|---|---|---|---|
| FY26 Q4 — Google Search, Solar NSW | Advertisement | $45,000 | **$46,000** | 25 |
| FY26 Q4 — Winter Roof Roadshow | Conference | $40,000 | **$42,000** | 25 |
| FY26 Q4 — Sydney Home Show | Trade Show | $30,000 | **$28,000** | 25 |
| FY26 Q4 — Newcastle Radio Sponsorship | Advertisement | $25,000 | **$24,000** | 25 |
| FY26 Q4 — Meta Retargeting | Advertisement | $25,000 | **$22,000** | 25 |
| FY26 Q4 — Referral Rewards | Referral Program | $15,000 | **$18,000** | 25 |
| **Total** | | **$180,000** | **$180,000** | **150** |

**All six are `Completed`. All six ended on or before 30/06/2026. Every one produced
exactly 25 leads.**

### The number that should stop you

| | |
|---|---|
| Leads generated | **150** |
| Leads **contacted** | **0** — all 150 are `Open - Not Contacted` |
| Leads **converted** | **0** — `NumberOfConvertedLeads` is 0 on all six campaigns |
| Leads owned by someone other than the admin | **0** |
| Days since the last campaign ended | **69** |

### The trap

**The trap is building a campaign ROI report.** It is the obvious deliverable, Salesforce
ships the fields for it, and it will produce a clean, professional, entirely worthless
table — because **return on investment requires returns, and there are none.**

Every campaign will show **$0 revenue, 0 converted leads, and an ROI of −100%.** Ranked
against each other they are identical. The report will be correct and will answer nothing.

**Worse, it will look like an answer.** A ranked table of six campaigns at −100% invites
the conclusion *"none of them worked"* — and that conclusion is not supported. **Nothing
here shows the campaigns failed.** It shows that what happens to a lead after it arrives
was never run. A campaign that generated 25 excellent leads and a campaign that generated
25 worthless ones are **indistinguishable in this org**, because neither was ever rung.

> **This is Ticket 2.1 §③/§④ a fourth time:** reaching for the measurement that is
> available instead of the one that is meaningful. In 2.1 it was record age standing in for
> evidence. Here it is spend standing in for performance.

**Exactly 25 leads per campaign is your other tell.** Real campaigns do not produce
identical yields. That is seed data telling you the lead volumes carry no signal at all —
so any per-campaign comparison built on them is comparing noise.

### Ask before you build

1. **Marcus — what decision does this number feed, and when?** "Which campaign should we
   run again" and "how much should we spend in Q1" need different work. **If he needs it
   this week, he needs to hear on Monday that the attribution does not exist**, not on
   Friday in a report.
2. **Is there any record of these leads being worked outside Salesforce?** 150 untouched
   leads is either a total process failure or leads that were worked in a spreadsheet and
   never written back. **Both are findings; they are different findings**, and the second
   is recoverable data.
3. **Who was supposed to call them?** The same question as CF-07, CF-02 and CF-13 Bucket B,
   arriving a fourth time on a fourth object. **Every open control in this org points at
   somebody who cannot log in.**

### Build

- **The campaign influence report Marcus can actually use**, in `SunRise Ops`,
  `organization` scope — **not** `user` (CF-21's correction; do not repeat it a third
  time).
- **A written attribution gap statement**: what this org can prove, what it cannot, and
  precisely which field would have to be populated for the ROI question to become
  answerable next quarter.
- **The forward fix, which is the real deliverable:** `CampaignId` on converted
  Opportunities, and a lead status progression that someone is rostered to move.

### Deliverable — Campaign Attribution Audit

`deliverables/ticket-4.1-campaign-attribution-audit.md`. It must state plainly, in its
first paragraph, that **campaign ROI cannot be computed in this org and why** — and it must
not bury that under a table that implies it can.

---

## Ticket 4.2 — The 150 leads nobody rang

**Sarah, Tuesday:** *"We keep hearing from people who filled in the form and never heard
back."*

**Read the ⚠️ section above first.** Web-to-Lead was deleted on 19/08, so there is no form
behind Sarah's complaint today — **which makes her complaint more interesting, not less.**
The 150 leads in the org arrived from the 17/08 seed load and 38 of them carry
`LeadSource = Web`. **The org records web leads it currently has no mechanism to receive.**

### What's there

| LeadSource | Count |
|---|---|
| Web | **38** |
| Phone Inquiry | **38** |
| Partner Referral | 37 |
| Other | 37 |

**All 150: `Open - Not Contacted`, unconverted, owned by the admin.**

### The trap

**The trap is fixing capture and calling it done.** A working web form that feeds 150 more
leads into the same pile is not an improvement — **it is the 2024 duplicate queue again**,
a mechanism that generates work nobody is rostered to do, and this register has now
documented that failure four times on four objects.

**Capture is the easy half and the half that shows.** The half that matters is what
happens in the sixty-nine days afterwards.

### Ask before you build

1. **Marcus — who owns an inbound lead, and what is the response-time commitment?** Without
   an answer, Default Lead Owner stays pointed at the admin (CF-16) and the pile grows.
2. **Do these 150 get worked, or written off?** Sixty-nine-day-old leads from completed
   campaigns are not fresh. **A deliberate write-off, recorded, is a defensible answer. An
   undeliberate one is what is happening now.** Do not decide this alone — it is $180,000
   of somebody's budget.

### Build

- Web-to-Lead form, saved to `seed/webform.html` and committed.
- **An active** Lead Auto-Response Rule. Write down what an inactive one costs — that was
  the planted bug, and it is worth understanding even unplanted.
- Complete field set on the form, State included.
- `Setup → Lead Settings → Default Lead Owner` — and **not** the admin, once Marcus answers.

### Deliverable — Lead Capture and Response Design

`deliverables/ticket-4.2-lead-capture-design.md`. Include the 19/08 deletion and how it
happened: **a correct decision in one ticket removing the substrate of another, with the
reasoning recorded and nobody to receive it.**

---

## Ticket 4.3 — A lead status that means something

**The 150 leads all sit in one status.** `Open - Not Contacted` is doing no work: it
describes 100% of the object, so it partitions nothing and reports on nothing.

### The trap

**The trap is bulk-updating the 150 to make the funnel look populated.** That is CF-02's
29/08 failure exactly — **clearing a control to make a report read better** — and this
register now has four instances of it. **A lead that has not been contacted is
`Open - Not Contacted`, and the honest funnel is a single bar.**

### Ask before you build

1. **Marcus — what are SunRise's actual lead stages**, and which one means "stop working
   this"? A status set without a terminal state produces exactly the pile now in the org.
2. **Does lead assignment need CF-15 answered first?** Probably. Routing to a role
   hierarchy that is Salesforce's US demo sample routes to fiction. **Say so rather than
   building on it.**

### Build

- Lead Status picklist reflecting SunRise's real process, **with a terminal state**.
- A `Leads by status and campaign` report in `SunRise Ops`, `organization` scope.
- **A written SOP for working an inbound lead** — the thing that was missing for 69 days.

### Deliverable — Lead Management SOP

`deliverables/sop-lead-management.md`. **Version it honestly.** If a section needs Marcus's
answer, mark it `✍️ TODO` and version it **v0.9 DRAFT** — the provisioning SOP is still
carrying that lesson three weeks later.

---

## What Week 4 should not repeat

**Four times now, on four objects, this org has produced work that nobody was rostered to
do:** the 74 duplicate record sets in 2024, CF-02's six addresses, CF-13 Bucket B's 21
groups, and now 150 leads sitting untouched for sixty-nine days.

**Every one was visible in the org the whole time.** None of them needed better tooling to
find. **The 150 leads are the largest instance yet and the only one that cost cash** —
$180,000 of it — and unlike the others, **this one was never even flagged.** There was no
overdue task, no unread queue, no report showing zero. The leads simply sat there, and the
campaigns that produced them were marked `Completed`.

> **A record marked `Completed` for the thing that finished, next to 150 records marked
> `Open - Not Contacted` for the thing that never started.** Both accurate. Nobody read
> them together.

**Do not let Week 4 add a fifth.** If Ticket 4.2 builds lead capture and nobody is rostered
to work what it captures, **the correct action is to say so in the deliverable and leave
the form switched off** — not to ship it and let the pile grow with better plumbing.
