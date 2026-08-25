/* Ticket 2.2 Phase 3 — before/after evidence for the duplicate management design.
   Extends seed/diagnose-duplicate-rule.apex: same probe-and-clean pattern, but
   it asks two different questions instead of one.

   PART A  Datacloud.FindDuplicates — WHICH rule sees each duplicate pattern.
           Read-only. Nothing is inserted. This is the part that shows the
           phone rule alone was not enough.

   PART B  Real inserts with DuplicateRuleHeader.AllowSave = true — what a rep
           actually experiences. AllowSave is the API equivalent of clicking
           "Save anyway" on an alert, so anything still refused is a genuine
           Block, not just a warning.

   Probe patterns, all drawn from duplicates really found in this org:
     1  phone twin, same format          — the phone rule's home ground
     2  phone twin, DIFFERENT format     — "(02) 4290 1310" vs "0242901310";
                                           the old Exact method missed this
     3  household twin                   — same address, new phone, middle
                                           initial ("Andrew J. Anderson")
     4  name breaks the naming standard  — validation rule territory
     5  edit a legacy "... Residence" account without renaming it              */

Integer drsBefore = [SELECT COUNT() FROM DuplicateRecordSet];
System.debug('============= TICKET 2.2 — BEFORE/AFTER TEST =============');
System.debug('Accounts in org       : ' + [SELECT COUNT() FROM Account]);
System.debug('Duplicate Record Sets : ' + drsBefore);

Account src = [SELECT Id, Name, Phone, BillingStreet, BillingCity, BillingPostalCode
               FROM Account
               WHERE Phone != null AND BillingStreet != null AND Name LIKE '%Residence'
               ORDER BY Name LIMIT 1];
System.debug('Probe source          : ' + src.Name + ' | ' + src.Phone
             + ' | ' + src.BillingStreet + ', ' + src.BillingCity);

String bare     = src.Name.removeEnd(' Residence');
String first    = bare.substringBefore(' ');
String last     = bare.substringAfterLast(' ');
String squashed = src.Phone.replaceAll('[^0-9]', '');   // same number, no formatting

List<Account> probes = new List<Account>{
    new Account(Name = 'Probe One',           Phone = src.Phone,
                BillingStreet = '999 Probe St', BillingCity = 'Sydney',
                BillingStateCode = 'NSW', BillingPostalCode = '2000',
                BillingCountryCode = 'AU', Service_Region__c = 'Sydney'),

    new Account(Name = 'Probe Two',           Phone = squashed,
                BillingStreet = '998 Probe St', BillingCity = 'Sydney',
                BillingStateCode = 'NSW', BillingPostalCode = '2000',
                BillingCountryCode = 'AU', Service_Region__c = 'Sydney'),

    new Account(Name = first + ' J. ' + last, Phone = '0499 000 001',
                BillingStreet = src.BillingStreet, BillingCity = src.BillingCity,
                BillingStateCode = 'NSW', BillingPostalCode = src.BillingPostalCode,
                BillingCountryCode = 'AU', Service_Region__c = 'Sydney'),

    new Account(Name = 'Probe Four Residence', Phone = '0499 000 002',
                BillingStreet = '997 Probe St', BillingCity = 'Sydney',
                BillingStateCode = 'NSW', BillingPostalCode = '2000',
                BillingCountryCode = 'AU', Service_Region__c = 'Sydney')
};

List<String> labels = new List<String>{
    'PROBE 1  phone twin, same format',
    'PROBE 2  phone twin, different format',
    'PROBE 3  household twin (same address, new phone, middle initial)',
    'PROBE 4  name breaks the naming standard'
};

/* ---------------- PART A — which rule sees what (read-only) ---------------- */
System.debug('');
System.debug('=========== PART A — which duplicate rule matches ===========');
List<Datacloud.FindDuplicatesResult> found = Datacloud.FindDuplicates.findDuplicates(probes);
for (Integer i = 0; i < found.size(); i++) {
    System.debug('---------------------------------------------------------');
    System.debug(labels[i] + '   [' + probes[i].Name + ' / ' + probes[i].Phone + ']');
    Boolean matched = false;
    for (Datacloud.DuplicateResult dr : found[i].getDuplicateResults()) {
        Integer hits = 0;
        for (Datacloud.MatchResult mr : dr.getMatchResults()) hits += mr.getMatchRecords().size();
        if (hits > 0) {
            matched = true;
            System.debug('   MATCHED by : ' + dr.getDuplicateRule()
                         + '   (' + hits + ' existing record(s))');
        }
    }
    if (!matched) System.debug('   MATCHED by : nothing — this pattern is invisible to every active rule');
}

/* ---------------- PART B — what a rep actually experiences ---------------- */
System.debug('');
System.debug('=========== PART B — insert with "Save anyway" allowed ===========');
System.debug('AllowSave=true means an Alert is overridden. Anything still');
System.debug('refused below is a real Block.');

Database.DMLOptions dml = new Database.DMLOptions();
dml.DuplicateRuleHeader.AllowSave = true;
dml.OptAllOrNone = false;

List<Database.SaveResult> results = Database.insert(probes, dml);
List<Id> created = new List<Id>();

for (Integer i = 0; i < results.size(); i++) {
    Database.SaveResult sr = results[i];
    System.debug('---------------------------------------------------------');
    System.debug(labels[i]);
    System.debug('   RESULT : ' + (sr.isSuccess() ? 'SAVED (alert only)' : 'REFUSED (hard block)'));
    if (sr.isSuccess()) {
        created.add(sr.getId());
    } else {
        for (Database.Error e : sr.getErrors()) {
            System.debug('   status : ' + e.getStatusCode());
            System.debug('   shown  : ' + e.getMessage());
        }
    }
}

System.debug('---------------------------------------------------------');
System.debug('PROBE 5  edit legacy "' + src.Name + '" without renaming it');
Database.SaveResult edit = Database.update(
    new Account(Id = src.Id, Description = 'ticket 2.2 probe'), false);
System.debug('   RESULT : ' + (edit.isSuccess() ? 'ALLOWED — rep is not trapped' : 'BLOCKED'));
for (Database.Error e : edit.getErrors()) {
    System.debug('   status : ' + e.getStatusCode());
    System.debug('   shown  : ' + e.getMessage());
}
if (edit.isSuccess()) update new Account(Id = src.Id, Description = null);

System.debug('');
System.debug('===================== RESULT =====================');
Integer drsAfter = [SELECT COUNT() FROM DuplicateRecordSet];
System.debug('Duplicate Record Sets before : ' + drsBefore);
System.debug('Duplicate Record Sets after  : ' + drsAfter
             + '   (new: ' + (drsAfter - drsBefore) + ')');
System.debug('Probes saved despite alert    : ' + created.size() + ' of 4');

if (!created.isEmpty()) {
    List<Account> toKill = new List<Account>();
    for (Id i : created) toKill.add(new Account(Id = i));
    delete toKill;
    System.debug('Cleaned up ' + toKill.size() + ' probe record(s).');
}
System.debug('Accounts in org after cleanup: ' + [SELECT COUNT() FROM Account]);
