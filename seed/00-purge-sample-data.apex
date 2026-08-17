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
   ============================================================================= */

System.debug('=== BEFORE ===');
System.debug('Accounts      ' + [SELECT COUNT() FROM Account]);
System.debug('Contacts      ' + [SELECT COUNT() FROM Contact]);
System.debug('Opportunities ' + [SELECT COUNT() FROM Opportunity]);
System.debug('Cases         ' + [SELECT COUNT() FROM Case]);
System.debug('Leads         ' + [SELECT COUNT() FROM Lead]);
System.debug('Campaigns     ' + [SELECT COUNT() FROM Campaign]);

// allOrNone = false: one record held by an entitlement or contract must not
// roll back the entire purge. Children first so cascade stays predictable.
Integer failed = 0;
List<Database.DeleteResult> results = new List<Database.DeleteResult>();

results.addAll(Database.delete([SELECT Id FROM Opportunity LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Case        LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Contact     LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Lead        LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Campaign    LIMIT 5000], false));
results.addAll(Database.delete([SELECT Id FROM Account     LIMIT 5000], false));

for (Database.DeleteResult r : results) {
    if (!r.isSuccess()) {
        failed++;
        System.debug('COULD NOT DELETE ' + r.getId() + ' :: ' + r.getErrors()[0].getMessage());
    }
}

System.debug('=== AFTER ===');
System.debug('Delete attempts : ' + results.size() + ', failures: ' + failed);
System.debug('Accounts        ' + [SELECT COUNT() FROM Account]);
System.debug('Opportunities   ' + [SELECT COUNT() FROM Opportunity]);
System.debug('Cases           ' + [SELECT COUNT() FROM Case]);
System.debug('Leads           ' + [SELECT COUNT() FROM Lead]);
System.debug('Campaigns       ' + [SELECT COUNT() FROM Campaign]);
System.debug('Products kept   ' + [SELECT COUNT() FROM Product2]);
