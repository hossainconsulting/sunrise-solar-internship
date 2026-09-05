/*  CF-23 — VERIFICATION SWEEP (read-only)
 *  ------------------------------------------------------------------
 *  Written 03/09/2026 to give CF-23's claim an artifact.
 *
 *  CF-23 closed on 02/09 asserting "all 187 ownable objects sweep to
 *  zero". Nothing was captured. cf-23-epic-remainder-transfer.apex
 *  sweeps ONE object per execution (TARGET) and re-counts only that
 *  one, so it never demonstrated the 187-object claim.
 *
 *  NOTE ON THE LIMIT — found running this on 03/09:
 *  Database.countQuery is a SOQL query and anonymous Apex allows 100.
 *  A 187-object sweep CANNOT run in one execution; the first attempt
 *  died on "Too many SOQL queries: 101". So the 02/09 sweep was either
 *  chunked or never ran as described. This script chunks explicitly.
 *
 *  Set CHUNK = 0, 1, 2 ... and run until PASS/FAIL covers every object.
 *  It WRITES NOTHING.
 */

Integer CHUNK = 0;          // <-- change per run
Integer SIZE  = 80;         // objects per execution, under the 100 SOQL cap

Set<String> names = new Set<String>{'OrgFarm EPIC','Jack Nguyen','Mia Kelly','Alan Brooks','Lisa Fernandez'};
Map<Id,User> users = new Map<Id,User>([SELECT Id, Name FROM User WHERE Name IN :names]);
Set<Id> ids = users.keySet();

// --- build the ownable-object list (describe only, no SOQL) ---
List<String> ownable = new List<String>();
for (Schema.SObjectType t : Schema.getGlobalDescribe().values()) {
    Schema.DescribeSObjectResult d = t.getDescribe();
    if (!d.isQueryable() || d.isCustomSetting() || d.isDeprecatedAndHidden()) continue;
    if (!d.fields.getMap().containsKey('ownerid')) continue;
    ownable.add(d.getName());
}
ownable.sort();

Integer total   = ownable.size();
Integer chunks  = (total + SIZE - 1) / SIZE;
Integer startIdx = CHUNK * SIZE;
Integer endIdx   = Math.min(startIdx + SIZE, total);

System.debug('CF23>> ownable_total,' + total);
System.debug('CF23>> chunks_required,' + chunks);
System.debug('CF23>> users_resolved,' + users.size() + ',of,' + names.size());

if (startIdx >= total) {
    System.debug('CF23>> CHUNK ' + CHUNK + ' is past the end. Nothing to do.');
    return;
}

Integer scanned = 0, skipped = 0, totalOwned = 0;
List<String> offenders = new List<String>();

for (Integer i = startIdx; i < endIdx; i++) {
    String api = ownable[i];
    try {
        Integer n = Database.countQuery('SELECT COUNT() FROM ' + api + ' WHERE OwnerId IN :ids');
        scanned++;
        if (n > 0) {
            totalOwned += n;
            offenders.add(api + '=' + n);
            System.debug('CF23>> owned,' + api + ',' + n);
        }
    } catch (Exception e) {
        skipped++;
        System.debug('CF23>> skip,' + api + ',' + e.getMessage().left(70));
    }
}

System.debug('CF23>> CHUNK,' + CHUNK + ',range,' + startIdx + '-' + (endIdx-1)
           + ',scanned,' + scanned + ',skipped,' + skipped + ',owned,' + totalOwned);
System.debug('CF23>> VERDICT,chunk' + CHUNK + ','
           + (totalOwned == 0 ? 'PASS' : 'FAIL,' + String.join(offenders, '|')));
