/* =============================================================================
   SunRise Solar Solutions — SEED 1 of 4 : ACCOUNTS, CONTACTS, DUPLICATES
   -----------------------------------------------------------------------------
   Run in:  Developer Console  →  Debug  →  Open Execute Anonymous Window
            (tick "Open Log" so you can read the summary at the end)

   PREREQUISITES — do these first or the script fails:
     1. Account.Service_Region__c exists
        Picklist, values: Sydney | Newcastle | Wollongong
        Setup → Object Manager → Account → Fields & Relationships → New
     2. Standard Account Matching Rule is ACTIVE
        Setup → Matching Rules → activate → wait for the "activation complete"
        email (indexing takes a few minutes on a new org)
     3. Standard Account Duplicate Rule is ACTIVE and its action on Create is
        "Allow" with "Report" ticked — NOT "Block".
        Setup → Duplicate Rules
        If it is set to Block, this script throws DUPLICATES_DETECTED.

   WHY prerequisite 2 & 3 matter: Salesforce only creates Duplicate Record Sets
   when a duplicate rule fires on save. It never scans existing data. If the
   rules are off while you seed, Week 2 has nothing to find.

   CREATES (at SCALE = 1):  150 clean Accounts + 150 Contacts
                            150 duplicate Accounts (120 pairs + 30 triplets)
   RUNTIME:  ~25 seconds
   ============================================================================= */

/* ---------------------------------------------------------------------------
   STORAGE — read this before you change SCALE.
   A Developer Edition org has roughly 5 MB of data storage, and Salesforce
   counts most records at 2 KB each. That is about 2,500 records for the WHOLE
   org, across every object. All four seed scripts together use ~1,800 at
   SCALE = 1, which leaves you room to work for twelve weeks.

   Check Setup → Storage Usage before and after seeding. Only raise SCALE if
   that page says you have room. Running out of storage mid-programme is a
   miserable thing to unpick.
   --------------------------------------------------------------------------- */
Integer SCALE = 1;

Integer CLEAN_COUNT = 150 * SCALE;   // households with a real relationship
Integer PAIR_COUNT  = 120 * SCALE;   // households duplicated once
Integer DUPE_COUNT  = 150 * SCALE;   // total duplicate records (the extra 30 make triplets)

List<String> FIRST = new List<String>{
  'James','Sarah','Michael','Emma','David','Olivia','Daniel','Sophie',
  'Matthew','Chloe','Andrew','Jessica','Thomas','Isabella','Ryan','Grace',
  'Nathan','Ruby','Joshua','Ella','Robert','Amelia','William','Zoe',
  'Benjamin','Mia','Samuel','Lily','Jack','Hannah','Lucas','Charlotte',
  'Ethan','Ava','Liam','Sienna','Noah','Layla','Oliver','Harper'
};

List<String> LAST = new List<String>{
  'Nguyen','Smith','Patel','Wilson','Brown','Taylor','Singh','Jones',
  'Lee','Martin','Anderson','Thompson','White','Harris','Clark','Lewis',
  'Walker','Hall','Young','King','Chen','Robinson','Murphy','Kelly',
  'Ryan','Campbell','Bennett','Foster','Hughes','Barnes','Tran','Ahmed',
  'Kaur','Osman','Fitzgerald','Whitfield','Doyle','Mancini','Kowalski','Silva'
};

List<String> STREETS = new List<String>{
  'Sunset Rd','George St','Victoria Ave','Railway Pde','Church St',
  'Park Ave','Beach Rd','Hill St','Grove Cres','Mill Lane',
  'Wattle St','Banksia Cl','Kurrajong Dr','Federation Way','Orchard Tce'
};

// Real NSW suburbs and postcodes, grouped by the office that services them.
Map<String, List<String>> REGIONS = new Map<String, List<String>>{
  'Sydney' => new List<String>{
    'Parramatta:2150','Blacktown:2148','Penrith:2750','Liverpool:2170',
    'Castle Hill:2154','Bankstown:2200','Chatswood:2067','Hornsby:2077',
    'Ryde:2112','Baulkham Hills:2153','Campbelltown:2560','Hurstville:2220'
  },
  'Newcastle' => new List<String>{
    'Newcastle:2300','Charlestown:2290','Maitland:2320','Cessnock:2325',
    'Raymond Terrace:2324','Warners Bay:2282','Belmont:2280','Singleton:2330'
  },
  'Wollongong' => new List<String>{
    'Wollongong:2500','Shellharbour:2529','Dapto:2530','Kiama:2533',
    'Corrimal:2518','Nowra:2541','Albion Park:2527'
  }
};

/* ---------------------------------------------------------------------------
   1. The clean Accounts — ~55% Sydney / 25% Newcastle / 20% Wollongong
   --------------------------------------------------------------------------- */
List<Account> clean = new List<Account>();

for (Integer i = 0; i < CLEAN_COUNT; i++) {
    Integer rmod  = Math.mod(i, 20);
    String region = (rmod < 11) ? 'Sydney' : (rmod < 16 ? 'Newcastle' : 'Wollongong');

    List<String> pool = REGIONS.get(region);
    List<String> sp   = pool[Math.mod(i * 7, pool.size())].split(':');

    String fn = FIRST[Math.mod(i * 13, FIRST.size())];
    String ln = LAST [Math.mod(i * 17, LAST.size())];

    clean.add(new Account(
        Name              = fn + ' ' + ln + ' Residence',
        Service_Region__c = region,
        Phone             = '(02) ' + (4000 + Math.mod(i * 29, 5000)) + ' ' + (1000 + Math.mod(i * 31, 9000)),
        BillingStreet     = (1 + Math.mod(i * 11, 220)) + ' ' + STREETS[Math.mod(i * 3, STREETS.size())],
        BillingCity       = sp[0],
        BillingState      = 'NSW',
        BillingPostalCode = sp[1],
        BillingCountry    = 'Australia'
    ));
}
insert clean;
System.debug('>>> Clean Accounts inserted: ' + clean.size());

/* ---------------------------------------------------------------------------
   2. One Contact per household — the person who answers the phone
   --------------------------------------------------------------------------- */
List<Contact> cons = new List<Contact>();
for (Account a : clean) {
    List<String> parts = a.Name.split(' ');
    cons.add(new Contact(
        AccountId         = a.Id,
        FirstName         = parts[0],
        LastName          = parts[1],
        Email             = parts[0].toLowerCase() + '.' + parts[1].toLowerCase()
                            + Math.mod(a.Name.length() * 31, 900) + '@example.com',
        Phone             = a.Phone,
        MailingStreet     = a.BillingStreet,
        MailingCity       = a.BillingCity,
        MailingState      = 'NSW',
        MailingPostalCode = a.BillingPostalCode,
        MailingCountry    = 'Australia'
    ));
}
insert cons;
System.debug('>>> Contacts inserted: ' + cons.size());

/* ---------------------------------------------------------------------------
   3. The mess — duplicate Accounts in four realistic dirty patterns.
      The first 30 households get TWO duplicates each, so they exist three
      times over — exactly the complaint in Marcus's Week 2 ticket.
   --------------------------------------------------------------------------- */
List<Account> dupes = new List<Account>();

for (Integer i = 0; i < DUPE_COUNT; i++) {
    Integer  srcIdx = (i < PAIR_COUNT) ? i : (i - PAIR_COUNT);   // overflow → second dupe
    Account  src    = clean[srcIdx];
    Integer  pattern = Math.mod(i, 4);

    Account d = new Account(
        Service_Region__c = src.Service_Region__c,
        BillingCity       = src.BillingCity,
        BillingState      = 'NSW',
        BillingPostalCode = src.BillingPostalCode,
        BillingCountry    = 'Australia'
    );

    if (pattern == 0) {
        // Re-keyed from a phone list: same name, phone stripped of formatting
        d.Name          = src.Name;
        d.Phone         = src.Phone.replace('(02) ', '02').replace(' ', '');
        d.BillingStreet = src.BillingStreet;

    } else if (pattern == 1) {
        // Web form: "Residence" dropped, street type spelled out in full
        d.Name          = src.Name.replace(' Residence', '');
        d.Phone         = src.Phone;
        d.BillingStreet = src.BillingStreet.replace(' St', ' Street')
                                           .replace(' Rd', ' Road')
                                           .replace(' Ave', ' Avenue');

    } else if (pattern == 2) {
        // Rep typed it fresh: middle initial added, mobile instead of landline
        List<String> p = src.Name.split(' ');
        d.Name          = p[0] + ' J. ' + p[1] + ' Residence';
        d.Phone         = '04' + (10000000 + Math.mod(i * 7919, 89999999));
        d.BillingStreet = src.BillingStreet;

    } else {
        // Spreadsheet import with CAPS LOCK on and no phone column mapped
        d.Name          = src.Name.toUpperCase();
        d.BillingStreet = src.BillingStreet.toUpperCase();
    }

    dupes.add(d);
}
insert dupes;
System.debug('>>> Duplicate Accounts inserted: ' + dupes.size());

/* ---------------------------------------------------------------------------
   4. Summary — check the duplicate rule actually fired
   --------------------------------------------------------------------------- */
Integer totalAccts = [SELECT COUNT() FROM Account];
Integer dupSets    = [SELECT COUNT() FROM DuplicateRecordSet];

System.debug('=====================================================');
System.debug('Total Accounts in org : ' + totalAccts);
System.debug('Duplicate Record Sets : ' + dupSets);
System.debug('=====================================================');
System.debug('If Duplicate Record Sets is 0, your Account duplicate rule was');
System.debug('inactive while this ran. Delete all Accounts, activate the rule,');
System.debug('and run this script again — Week 2 depends on those sets.');
