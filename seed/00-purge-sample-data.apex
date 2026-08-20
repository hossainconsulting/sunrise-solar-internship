/* =============================================================================
   SunRise Solar Solutions — SEED 0 of 4 : CLEAR THE STOCK SAMPLE DATA
   -----------------------------------------------------------------------------
   Every fresh Developer Edition org ships with sample records. They must go
   before seeding, for one reason above all: Week 3 asks you to explain a quota
   miss using a deliberate ~12% decline in average deal size. Thirty-one
   unrelated sample Opportunities sitting in the same date range make every
   number in that analysis wrong, and nothing in the org would tell you why.

   KEEPS Product2 - the 17 sample products cost nothing and Week 4's campaign
   work can use them.

   Everything deleted here is recoverable from the Recycle Bin for 15 days.

   -----------------------------------------------------------------------------
   PREREQUISITE - tick Marketing User on your own user record first.

   Without it this script does not partially run: it does not COMPILE, and the
   error names only the Campaign line -

       DML operation Delete not allowed on Campaign

   Apex checks object DML permissions at compile time, so one ungranted object
   blocks the entire purge. Marketing User is a checkbox on the USER record, not
   a profile permission, and it is off by default even for System Administrators.

   Setup -> Users -> [you] -> Edit -> tick Marketing User. Or set it over the
   API, which is faster across several orgs:

       sf data update record -o <alias> --sobject User --record-id <your 005 id> \
          --values "UserPermissionsMarketingUser=true"

   -----------------------------------------------------------------------------
   DELETE ORDER matters, and it is not alphabetical:

     Opportunity           - independent
     Case                  - references Entitlement, so it goes before them
     Entitlement           - HOLDS Account and Contact; blocks both until gone
     ServiceContract       - parent of Entitlement in some sample sets
     Contact               - referenced by Entitlement, now free
     Lead, Campaign        - independent
     Account               - last; everything above pointed at it

   A fresh DE org ships with "Sample Account for Entitlements" attached to
   "Sample Entitlement". Delete Accounts without clearing that first and you get

       Your attempt to delete Sample Account for Entitlements could not be
       completed because it is associated with the following entitlements.

   which reads like the Account is undeletable. It is not - the reference is the
   blocker, not the record. Same shape as deactivating a system user that still
   holds a Default Case Owner assignment: clear the reference, then the object.
   ============================================================================= */

System.debug('=== BEFORE ===');
System.debug('Accounts        ' + [SELECT COUNT() FROM Account]);
System.debug('Contacts        ' + [SELECT COUNT() FROM Contact]);
System.debug('Opportunities   ' + [SELECT COUNT() FROM Opportunity]);
System.debug('Cases           ' + [SELECT COUNT() FROM Case]);
System.debug('Leads           ' + [SELECT COUNT() FROM Lead]);
System.debug('Campaigns       ' + [SELECT COUNT() FROM Campaign]);
System.debug('Entitlements    ' + [SELECT COUNT() FROM Entitlement]);
System.debug('ServiceContracts' + [SELECT COUNT() FROM ServiceContract]);

// allOrNone = false: one record held by an entitlement or contract must not
// roll back the entire purge. Children first so cascade stays predictable.
Integer failed = 0;
List<Database.DeleteResult> results = new List<Database.DeleteResult>();

results.addAll(Database.delete([SELECT Id FROM Opportunity     LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Case            LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Entitlement     LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM ServiceContract LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Contact         LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Lead            LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Campaign        LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Account         LIMIT 5000], false));

for (Database.DeleteResult r : results) {
    if (!r.isSuccess()) {
        failed++;
        System.debug('COULD NOT DELETE ' + r.getId() + ' :: ' + r.getErrors()[0].getMessage());
    }
}

System.debug('=== AFTER ===');
System.debug('Delete attempts : ' + results.size() + ', failures: ' + failed);
System.debug('Accounts        ' + [SELECT COUNT() FROM Account]);
System.debug('Contacts        ' + [SELECT COUNT() FROM Contact]);
System.debug('Opportunities   ' + [SELECT COUNT() FROM Opportunity]);
System.debug('Cases           ' + [SELECT COUNT() FROM Case]);
System.debug('Leads           ' + [SELECT COUNT() FROM Lead]);
System.debug('Campaigns       ' + [SELECT COUNT() FROM Campaign]);
System.debug('Entitlements    ' + [SELECT COUNT() FROM Entitlement]);
System.debug('Products kept   ' + [SELECT COUNT() FROM Product2]);

if (failed == 0) {
    System.debug('Clean. Every stock record removed except Product2.');
} else {
    System.debug('Check the COULD NOT DELETE lines above - each names the reference holding the record.');
}
