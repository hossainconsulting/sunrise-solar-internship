/* =============================================================================
   SunRise Solar Solutions — SEED 4 of 4 : CAMPAIGNS, LEADS, CAMPAIGN MEMBERS
   -----------------------------------------------------------------------------
   Builds exactly the situation Zara describes in her Week 4 email:

     "Right now I can pull number of leads per campaign but I can't tie it to
      actual revenue. I've got about $180K of spend across 6 campaigns."

   So: six campaigns totalling $180,000 of actual cost, each with campaign
   members — and every Opportunity in the org with a NULL Primary Campaign
   Source. The plumbing between marketing spend and revenue simply isn't there.
   Connecting it is Week 4's job.

   PREREQUISITES: seed scripts 01–03 have been run.
   RUNTIME:       ~30 seconds
   ============================================================================= */

/* ---------------------------------------------------------------------------
   1. Six campaigns, $180,000 of spend
   --------------------------------------------------------------------------- */
List<Campaign> camps = new List<Campaign>{
    new Campaign(Name='FY26 Q4 - Winter Roof Roadshow',        Type='Conference',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,4,6),  EndDate=Date.newInstance(2026,5,29),
                 BudgetedCost=40000, ActualCost=42000, ExpectedRevenue=520000),

    new Campaign(Name='FY26 Q4 - Sydney Home Show',            Type='Trade Show',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,5,15), EndDate=Date.newInstance(2026,5,17),
                 BudgetedCost=30000, ActualCost=28000, ExpectedRevenue=380000),

    new Campaign(Name='FY26 Q4 - Google Search - Solar NSW',   Type='Advertisement',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,4,1),  EndDate=Date.newInstance(2026,6,30),
                 BudgetedCost=45000, ActualCost=46000, ExpectedRevenue=610000),

    new Campaign(Name='FY26 Q4 - Meta Retargeting',            Type='Advertisement',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,4,1),  EndDate=Date.newInstance(2026,6,30),
                 BudgetedCost=25000, ActualCost=22000, ExpectedRevenue=180000),

    new Campaign(Name='FY26 Q4 - Referral Rewards',            Type='Referral Program',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,4,1),  EndDate=Date.newInstance(2026,6,30),
                 BudgetedCost=15000, ActualCost=18000, ExpectedRevenue=290000),

    new Campaign(Name='FY26 Q4 - Newcastle Radio Sponsorship', Type='Advertisement',
                 Status='Completed', IsActive=true,
                 StartDate=Date.newInstance(2026,4,1),  EndDate=Date.newInstance(2026,6,30),
                 BudgetedCost=25000, ActualCost=24000, ExpectedRevenue=150000)
};
insert camps;
System.debug('>>> Campaigns inserted: ' + camps.size()
    + ' (total actual cost $180,000)');

/* ---------------------------------------------------------------------------
   2. Leads sitting in the org from those campaigns
   --------------------------------------------------------------------------- */
List<String> FIRST = new List<String>{
  'Aaron','Bianca','Callum','Danika','Elliot','Freya','Gareth','Heidi',
  'Isaac','Jorja','Kieran','Leila','Marcus','Nadia','Owen','Priya',
  'Quentin','Rosa','Simon','Tanya','Umar','Vanessa','Wesley','Xanthe'
};
List<String> LAST = new List<String>{
  'Abbott','Beckett','Carrington','Delaney','Everett','Franklin','Gallagher',
  'Holloway','Ibrahim','Jarvis','Kensington','Lombardi','Mahoney','Novak',
  'Ortega','Pemberton','Quigley','Rasmussen','Sutherland','Tremblay'
};
Map<String, List<String>> SUBS = new Map<String, List<String>>{
  'Sydney'     => new List<String>{'Parramatta:2150','Blacktown:2148','Penrith:2750','Liverpool:2170','Castle Hill:2154','Chatswood:2067'},
  'Newcastle'  => new List<String>{'Newcastle:2300','Charlestown:2290','Maitland:2320','Cessnock:2325'},
  'Wollongong' => new List<String>{'Wollongong:2500','Shellharbour:2529','Dapto:2530','Kiama:2533'}
};
List<String> LEAD_STATUS = new List<String>{
    'Open - Not Contacted','Working - Contacted','Closed - Not Converted'
};
List<String> LEAD_SOURCE = new List<String>{'Web','Phone Inquiry','Partner Referral','Other'};

Integer SCALE = 1;   // keep this the same as the earlier scripts
List<Lead> leads = new List<Lead>();
for (Integer i = 0; i < 150 * SCALE; i++) {
    Integer rmod  = Math.mod(i, 20);
    String region = (rmod < 11) ? 'Sydney' : (rmod < 16 ? 'Newcastle' : 'Wollongong');
    List<String> pool = SUBS.get(region);
    List<String> sp   = pool[Math.mod(i * 7, pool.size())].split(':');

    String fn = FIRST[Math.mod(i * 13, FIRST.size())];
    String ln = LAST [Math.mod(i * 17, LAST.size())];

    leads.add(new Lead(
        FirstName  = fn,
        LastName   = ln,
        Company    = fn + ' ' + ln + ' (Residential)',
        Email      = fn.toLowerCase() + '.' + ln.toLowerCase() + i + '@example.com',
        Phone      = '(02) ' + (4000 + Math.mod(i * 29, 5000)) + ' ' + (1000 + Math.mod(i * 31, 9000)),
        Status     = LEAD_STATUS[Math.mod(i * 3, LEAD_STATUS.size())],
        LeadSource = LEAD_SOURCE[Math.mod(i * 5, LEAD_SOURCE.size())],
        Street     = (1 + Math.mod(i * 11, 220)) + ' Solar Way',
        City       = sp[0],
        State      = 'NSW',
        PostalCode = sp[1],
        Country    = 'Australia'
    ));
}
insert leads;
System.debug('>>> Leads inserted: ' + leads.size());

/* ---------------------------------------------------------------------------
   3. Attach leads to campaigns — so Zara CAN count leads per campaign
   --------------------------------------------------------------------------- */
List<CampaignMember> members = new List<CampaignMember>();
for (Integer i = 0; i < leads.size(); i++) {
    members.add(new CampaignMember(
        CampaignId = camps[Math.mod(i, camps.size())].Id,
        LeadId     = leads[i].Id,
        Status     = Math.mod(i, 3) == 0 ? 'Responded' : 'Sent'
    ));
}
insert members;
System.debug('>>> Campaign Members inserted: ' + members.size());

/* ---------------------------------------------------------------------------
   4. Prove the gap
   --------------------------------------------------------------------------- */
Integer oppsWithCampaign = [SELECT COUNT() FROM Opportunity WHERE CampaignId != null];
Integer oppsTotal        = [SELECT COUNT() FROM Opportunity];

System.debug('=====================================================');
System.debug('Opportunities total                    : ' + oppsTotal);
System.debug('Opportunities with a Primary Campaign  : ' + oppsWithCampaign);
System.debug('=====================================================');
System.debug('That second number should be 0. Zara can count leads per campaign');
System.debug('but there is no path from a campaign to a dollar of revenue.');
System.debug('That is the Week 4 problem, now real in your org.');
