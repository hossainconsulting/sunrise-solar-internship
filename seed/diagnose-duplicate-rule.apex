/* Diagnostic: does the Account duplicate rule actually fire on insert?
   Inserts one blatant duplicate of an existing seeded account and reports
   whether Salesforce created a Duplicate Record Set for it.            */

Account src = [SELECT Id, Name, BillingStreet, BillingCity, BillingPostalCode
               FROM Account WHERE Service_Region__c != null
               ORDER BY CreatedDate LIMIT 1];

System.debug('Cloning: ' + src.Name + ' / ' + src.BillingStreet);

Integer before = [SELECT COUNT() FROM DuplicateRecordSet];

Account twin = new Account(
    Name               = src.Name,               // identical name
    BillingStreet      = src.BillingStreet,      // identical street
    BillingCity        = src.BillingCity,
    BillingPostalCode  = src.BillingPostalCode,
    BillingStateCode   = 'NSW',
    BillingCountryCode = 'AU',
    Service_Region__c  = 'Sydney'
);

Database.SaveResult sr = Database.insert(twin, false);

System.debug('Insert success : ' + sr.isSuccess());
if (!sr.isSuccess()) {
    for (Database.Error e : sr.getErrors()) {
        System.debug('  error: ' + e.getStatusCode() + ' - ' + e.getMessage());
    }
}

Integer after = [SELECT COUNT() FROM DuplicateRecordSet];
System.debug('Duplicate Record Sets before : ' + before);
System.debug('Duplicate Record Sets after  : ' + after);
System.debug(after > before
    ? '>>> RULE IS FIRING - the seeded duplicates simply did not match the rule criteria'
    : '>>> RULE IS NOT FIRING - check Action on Create includes the Report option');

// clean up the probe
if (sr.isSuccess()) { delete new Account(Id = sr.getId()); }
