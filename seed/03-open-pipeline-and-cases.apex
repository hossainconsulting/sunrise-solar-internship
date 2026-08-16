/* =============================================================================
   SunRise Solar Solutions — SEED 3 of 4 : OPEN PIPELINE + SERVICE CASES
   -----------------------------------------------------------------------------
   Open pipeline gives Week 3 and Week 9 something to report coverage on.
   Cases give Week 8 (Service Cloud) and Week 9 (SLA reporting) real volume.

   PREREQUISITES: seed scripts 01 and 02 have been run.
   RUNTIME:       ~30 seconds

   ⚠ ONE LIMITATION YOU CANNOT WORK AROUND
   Apex cannot backdate CreatedDate outside a test context. Every Case created
   here is "created now". That matters in Week 8.2, where you build escalation
   rules for cases sitting in New for 4+ business hours — you will have nothing
   that old to trigger on. The fix is in the guide: temporarily set the
   escalation age to 30 minutes to prove the rule fires, screenshot the
   evidence, then set it back to 4 hours before you call it done.
   ============================================================================= */

List<User> reps = [SELECT Id FROM User
                   WHERE IsActive = true AND Profile.UserLicense.Name = 'Salesforce'
                   ORDER BY CreatedDate LIMIT 8];

Integer SCALE = 1;   // keep this the same as scripts 01 and 02

List<Account> accts = [SELECT Id, Name, Service_Region__c FROM Account
                       WHERE Service_Region__c != null
                       ORDER BY CreatedDate LIMIT 150];

Map<Id, Id> primaryContact = new Map<Id, Id>();
for (Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId != null LIMIT 400]) {
    primaryContact.put(c.AccountId, c.Id);
}

/* ---------------------------------------------------------------------------
   1. Open pipeline — the deals still in flight
   --------------------------------------------------------------------------- */
List<String> OPEN_STAGES = new List<String>{
    'Prospecting','Qualification','Needs Analysis','Value Proposition',
    'Id. Decision Makers','Proposal/Price Quote','Negotiation/Review'
};
List<String> SYSTEMS = new List<String>{
    '6.6kW Rooftop Solar','8.8kW Rooftop Solar','10kW Rooftop Solar',
    '13.2kW Rooftop Solar','6.6kW Solar + 10kWh Battery','Battery Retrofit 13.5kWh'
};
List<String> SOURCES = new List<String>{'Web','Phone Inquiry','Partner Referral','Other'};

List<Opportunity> pipeline = new List<Opportunity>();
Date pipeStart = Date.newInstance(2026, 7, 1);

for (Integer n = 0; n < 150 * SCALE; n++) {
    Account acc = accts[Math.mod(n * 7, accts.size())];
    Decimal amt = 12800 * (0.70 + (Math.mod(n * 41, 61) / 100.0));

    pipeline.add(new Opportunity(
        Name       = acc.Name + ' - ' + SYSTEMS[Math.mod(n * 3, SYSTEMS.size())],
        AccountId  = acc.Id,
        OwnerId    = reps[Math.mod(n, reps.size())].Id,
        // Weighted toward early stages, which is what a thin pipeline looks like
        StageName  = OPEN_STAGES[Math.mod(n * n, OPEN_STAGES.size())],
        CloseDate  = pipeStart.addDays(Math.mod(n * 13, 150)),
        Amount     = amt.setScale(0),
        LeadSource = SOURCES[Math.mod(n * 5, SOURCES.size())],
        Type       = Math.mod(n, 7) == 0 ? 'Existing Customer - Upgrade' : 'New Customer'
    ));
}
insert pipeline;
System.debug('>>> Open Opportunities inserted: ' + pipeline.size());

/* ---------------------------------------------------------------------------
   2. Service cases — weighted to the same regional mix
   --------------------------------------------------------------------------- */
List<String> SUBJECTS = new List<String>{
    'Inverter showing fault code F13',
    'System not exporting to grid since Tuesday',
    'App showing zero generation',
    'Panel cracked after storm',
    'Battery not discharging overnight',
    'Request for performance report',
    'Question about feed-in tariff on bill',
    'Isolator switch tripping intermittently',
    'Monitoring portal login not working',
    'Requesting annual service booking',
    'Bird proofing quote request',
    'Warranty claim - microinverter'
};
List<String> ORIGINS  = new List<String>{'Phone','Email','Web'};
List<String> STATUSES = new List<String>{'New','Working','Escalated','Closed'};
List<String> PRIORITY = new List<String>{'Low','Medium','High'};
List<String> REASONS  = new List<String>{'Installation','Performance','Breakdown','Equipment Complexity','Other'};

List<Case> cases = new List<Case>();

for (Integer n = 0; n < 140 * SCALE; n++) {
    Account acc = accts[Math.mod(n * 11, accts.size())];

    // 25% New, 30% Working, 8% Escalated, 37% Closed — a realistic stale backlog
    Integer s = Math.mod(n, 100);
    String status = (s < 25) ? 'New' : (s < 55) ? 'Working' : (s < 63) ? 'Escalated' : 'Closed';

    cases.add(new Case(
        AccountId   = acc.Id,
        ContactId   = primaryContact.get(acc.Id),
        Subject     = SUBJECTS[Math.mod(n * 3, SUBJECTS.size())],
        Description = 'Logged by the service team. Customer in ' + acc.Service_Region__c
                      + ' region. Original detail was not captured consistently.',
        Status      = status,
        Origin      = ORIGINS[Math.mod(n, ORIGINS.size())],
        Priority    = PRIORITY[Math.mod(n * 7, PRIORITY.size())],
        Reason      = REASONS[Math.mod(n * 5, REASONS.size())]
        // NOTE: no queue, no region routing, no SLA field. All of that is
        // yours to build in Week 8.
    ));
}
insert cases;
System.debug('>>> Cases inserted: ' + cases.size());

/* --- Summary --------------------------------------------------------------- */
System.debug('=====================================================');
System.debug('Open pipeline value : $' +
    ((Decimal)[SELECT SUM(Amount) s FROM Opportunity WHERE IsClosed = false][0].get('s')).setScale(0));
System.debug('Open cases          : ' +
    [SELECT COUNT() FROM Case WHERE Status != 'Closed']);
System.debug('=====================================================');
