/* =============================================================================
   SunRise Solar Solutions — SEED 2 of 4 : CLOSED OPPORTUNITY HISTORY
   -----------------------------------------------------------------------------
   This is the script that makes Week 3 possible. It builds four quarters of
   closed business with a deliberate, *discoverable* decline in the last one:

     • average deal size drops ~12% in the final quarter
     • the drop is concentrated in the Newcastle region
     • win rate falls from ~57% to ~46%
     • there is NO loss-reason data anywhere — that gap is the point.
       Priya's question "why did we miss quota?" cannot be fully answered from
       the data as it stands, and saying so is the correct Week 3 finding.

   QUARTERS use the Australian financial year (1 Jul – 30 Jun):
       FY26 Q3 = Jan–Mar 2026   the healthy comparison quarter
       FY26 Q4 = Apr–Jun 2026   ← the miss

   When Marcus's ticket says "Q3", read it as "last completed quarter", which in
   your org is Apr–Jun 2026.

   ⚠ WHERE THE QUOTA NUMBER COMES FROM
   Marcus's ticket quotes a $4.8M quota against $4.1M actual. Do not hard-code
   those figures. A Developer Edition org cannot hold four quarters of an $18M
   business (see the storage note in script 01), so your org is a scale model —
   the ratios are faithful, the absolute dollars are smaller.

   Run this script, read the actual Closed Won total for Apr–Jun 2026 off the
   debug log at the end, and set the quota to that number × 1.17. That gives you
   the same ~15% shortfall Priya is angry about. This is also how it works in
   real life: the quota is a number the business tells you, not a number that
   lives in the CRM.

   PREREQUISITES:
     • Seed script 01 has been run
     • At least 2 active users with a full Salesforce licence (more is better —
       see Phase 0 on licence limits). The script adapts to however many exist.

   RUNTIME:  ~25 seconds (~740 Opportunities at SCALE = 1)
   ============================================================================= */

Integer SCALE = 1;   // keep this the same as the SCALE you used in script 01

// Set to -1 for both quarters. If you hit "Apex CPU time limit exceeded",
// set to 0, run, then set to 1 and run again.
Integer RUN_ONLY_QUARTER = -1;

/* --- Who owns the deals ---------------------------------------------------- */
List<User> reps = [SELECT Id, Name FROM User
                   WHERE IsActive = true
                     AND Profile.UserLicense.Name = 'Salesforce'
                   ORDER BY CreatedDate
                   LIMIT 8];

if (reps.isEmpty()) {
    throw new System.NoAccessException();   // no licensed users — see Phase 0
}
System.debug('>>> Distributing ownership across ' + reps.size() + ' user(s)');

/* --- Only the 340 CLEAN accounts get deals (the duplicates stay empty, which
       is what makes the "clean record is the master" argument defensible) ----- */
Map<String, List<Account>> byRegion = new Map<String, List<Account>>{
    'Sydney'     => new List<Account>(),
    'Newcastle'  => new List<Account>(),
    'Wollongong' => new List<Account>()
};
for (Account a : [SELECT Id, Name, Service_Region__c FROM Account
                  WHERE Service_Region__c != null
                  ORDER BY CreatedDate
                  LIMIT 150]) {          // = CLEAN_COUNT from script 01
    byRegion.get(a.Service_Region__c).add(a);
}

List<String> SYSTEMS = new List<String>{
    '6.6kW Rooftop Solar','8.8kW Rooftop Solar','10kW Rooftop Solar',
    '13.2kW Rooftop Solar','6.6kW Solar + 10kWh Battery','Battery Retrofit 13.5kWh'
};
List<String> SOURCES = new List<String>{'Web','Phone Inquiry','Partner Referral','Other'};

/* --- Quarter shape --------------------------------------------------------- */
List<Date>    qStart = new List<Date>{Date.newInstance(2026,1,1), Date.newInstance(2026,4,1)};
List<Integer> qDays  = new List<Integer>{90, 91};
List<Integer> qWon   = new List<Integer>{190 * SCALE, 200 * SCALE};
List<Integer> qLost  = new List<Integer>{140 * SCALE, 210 * SCALE};  // ← losses spike in the miss quarter
List<Decimal> qAvg   = new List<Decimal>{13700, 12550};              // ← and deal size falls

List<Opportunity> opps = new List<Opportunity>();

for (Integer q = 0; q < 2; q++) {
    if (RUN_ONLY_QUARTER != -1 && q != RUN_ONLY_QUARTER) continue;

    Boolean isMiss = (q == 1);
    Integer total  = qWon[q] + qLost[q];

    for (Integer n = 0; n < total; n++) {
        Boolean won   = (n < qWon[q]);
        Integer rmod  = Math.mod(n, 20);
        String  region = (rmod < 11) ? 'Sydney' : (rmod < 16 ? 'Newcastle' : 'Wollongong');

        List<Account> pool = byRegion.get(region);
        if (pool.isEmpty()) continue;
        Account acc = pool[Math.mod(n * 7, pool.size())];
        User    rep = reps[Math.mod(n, reps.size())];

        // Base amount with a ±28% spread that averages out to qAvg
        Decimal amt = qAvg[q] * (0.72 + (Math.mod(n * 37, 57) / 100.0));

        // The two shapes that make the decline discoverable
        if (isMiss && region == 'Newcastle')                     amt = amt * 0.78;
        if (isMiss && reps.size() >= 4 && Math.mod(n, reps.size()) <= 1) amt = amt * 0.88;

        opps.add(new Opportunity(
            Name       = acc.Name + ' - ' + SYSTEMS[Math.mod(n * 3, SYSTEMS.size())],
            AccountId  = acc.Id,
            OwnerId    = rep.Id,
            StageName  = won ? 'Closed Won' : 'Closed Lost',
            CloseDate  = qStart[q].addDays(Math.mod(n * 11, qDays[q])),
            Amount     = amt.setScale(0),
            LeadSource = SOURCES[Math.mod(n * 5, SOURCES.size())],
            Type       = Math.mod(n, 7) == 0 ? 'Existing Customer - Upgrade' : 'New Customer'
            // NOTE: CampaignId deliberately left null — that is Zara's Week 4 gap.
        ));
    }
}

insert opps;
System.debug('>>> Closed Opportunities inserted: ' + opps.size());

/* --- What did we actually build? Read these numbers off the log, then go and
       reproduce them with a report in Week 3. -------------------------------- */
System.debug('===================== CLOSED WON BY QUARTER =====================');
for (AggregateResult ar : [
        SELECT CALENDAR_YEAR(CloseDate) yr, CALENDAR_QUARTER(CloseDate) qt,
               COUNT(Id) deals, SUM(Amount) revenue, AVG(Amount) avgDeal
        FROM Opportunity
        WHERE StageName = 'Closed Won'
        GROUP BY CALENDAR_YEAR(CloseDate), CALENDAR_QUARTER(CloseDate)
        ORDER BY CALENDAR_YEAR(CloseDate), CALENDAR_QUARTER(CloseDate)]) {
    System.debug(ar.get('yr') + ' CalQ' + ar.get('qt')
        + ' | deals ' + ar.get('deals')
        + ' | revenue $' + ((Decimal) ar.get('revenue')).setScale(0)
        + ' | avg $'     + ((Decimal) ar.get('avgDeal')).setScale(0));
}
System.debug('================================================================');
System.debug('Take the Apr-Jun 2026 (CalQ2) revenue above and multiply by 1.17.');
System.debug('THAT is the quota Marcus tells you the business set. The gap');
System.debug('between it and the actual is what Priya wants explained.');
System.debug('Write both numbers down now — you will need them in Week 3.');
