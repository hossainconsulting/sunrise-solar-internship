# Status note to Marcus — Ticket 1.1 (new hire provisioning)

**19/08/2026** · v2 — rewritten after Marcus's review. Every number below is
verified against the org.

---

Marcus — status on the three Monday starters. **I need a decision from you by
close of business Friday.**

**One of three is provisioned.** Ben Carter is live as a Newcastle sales rep —
Standard User profile, Newcastle Sales Team role, Manager set, built from scratch
rather than cloned. I logged in as him and confirmed he can see and create
Opportunities and can't touch Campaigns.

**We were at 4 of 4 Salesforce licences when I started.** I freed one by
deactivating OrgFarm EPIC, the provisioning account Salesforce creates with the
org. It has no interactive human logins — only automated access from Salesforce's
own provisioning app. Clearing it meant unpicking six system references it was
still attached to; that's all in the build log with the reasoning, including two
config deletions I'd have handled differently in a production org.

Ben took that recovered licence, so **we're back at 4 of 4 with nothing spare.**

**The remaining two hires need a decision, and I don't think it's the one I first
thought.** There are three options, not two:

1. **Review Jack and Mia's licence type.** Both are on full Salesforce licences and
   **neither has ever logged in.** We have **six Salesforce Platform licences
   sitting completely unused.** If either of them works outside Opportunities,
   Leads and Campaigns, Platform covers them and frees a Salesforce licence at zero
   cost. I'm not proposing we switch anyone off — just that we check whether the
   licence they're holding is the one they need.
2. **Check what the service tech actually needs.** You said to talk to Sarah about
   his access. If his work is Cases and field jobs rather than pipeline, that's a
   different licence question and possibly a cheaper answer. I haven't spoken to
   her yet — worth doing before we spend anything.
3. **Purchase.** If 1 and 2 come back negative, this is the answer, and it needs
   starting today to land before Monday.

**What happens if this doesn't get decided:** two people turn up Monday morning
and can't log in. That's an onboarding problem before it's a licence problem, and
someone has to have that conversation with them. I'd rather it didn't come as a
surprise on the day.

So: can I go and ask Sarah what the service tech needs, and can you tell me whether
Jack and Mia's licence types are mine to review? If the answer to both is no, I
need the purchase started today and I'll chase whoever owns that.

If none of it is possible before Monday, tell me which of the two takes priority.
I'll have the other's provisioning record written up and ready to execute the
moment a licence frees up.

One separate thing while you're reading: **Ben can open Setup.** That's stock
Salesforce — the Standard User profile ships with read-only Setup visibility, and
he can't change anything. But if we don't want sales reps browsing Setup, that's a
profile change and I'd rather ask now than in the Week 10 audit.

— Hemayet
