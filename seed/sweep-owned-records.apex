/*
 * Owned-records SWEEP — the multi-user form of check-owned-records.apex
 *
 * Same gate, but scans a set of users in one pass: one grouped query per object
 * instead of one query per object per user. Scanning 7 accounts across 144 objects
 * costs 144 queries here rather than 1,008.
 *
 * Written for the 26/08 sweep of every non-human account in the org, after the
 * OrgFarm EPIC finding (247 records still owned by a user deactivated on 19/08).
 * EPIC was found by accident; nothing had ever checked the service accounts.
 *
 * Same SOQL ceiling applies — 144 objects, 100 queries per transaction. Run, then
 * re-run with SKIP set to the printed value. It says "Scan complete" at the end.
 */

Set<String> TARGET_NAMES = new Set<String>{
    'Automated Process', 'Chatter Expert', 'Data.com Clean', 'Integration User',
    'Platform Integration User', 'Security User', 'System'
};
Integer SKIP = 0;    // <-- set to the "NEXT SKIP" printed by the previous run

Integer QUERY_CEILING = 90;

Map<Id, String> userNames = new Map<Id, String>();
for (User u : [SELECT Id, Name FROM User WHERE Name IN :TARGET_NAMES]) {
    userNames.put(u.Id, u.Name);
}
Set<Id> uids = userNames.keySet();
System.debug('Sweeping ' + uids.size() + ' accounts: ' + String.join(new List<String>(userNames.values()), ', '));

// Describe pass — no SOQL cost. Sorted so slices are deterministic.
List<String> targets = new List<String>();
for (Schema.SObjectType t : Schema.getGlobalDescribe().values()) {
    Schema.DescribeSObjectResult d = t.getDescribe();
    if (!d.isQueryable() || !d.isAccessible() || d.isCustomSetting()) continue;
    if (d.isDeprecatedAndHidden() || !d.isCreateable()) continue;
    if (!d.fields.getMap().containsKey('OwnerId')) continue;
    String api = d.getName();
    if (api.endsWith('__Share') || api.endsWith('__History') || api.endsWith('History')
        || api.endsWith('Feed') || api.endsWith('__Tag') || api.endsWith('ChangeEvent')
        || api.endsWith('Event')) continue;
    targets.add(api);
}
targets.sort();

List<String> findings = new List<String>();
Integer grandTotal = 0;
Integer i = SKIP;
Boolean truncated = false;

while (i < targets.size()) {
    if (Limits.getQueries() >= QUERY_CEILING) { truncated = true; break; }
    String api = targets[i];
    try {
        for (AggregateResult ar : Database.query(
                'SELECT OwnerId oid, COUNT(Id) c FROM ' + api +
                ' WHERE OwnerId IN :uids GROUP BY OwnerId')) {
            Integer c = (Integer) ar.get('c');
            if (c > 0) {
                findings.add(userNames.get((Id) ar.get('oid')) + '  ->  ' + api + ' : ' + c);
                grandTotal += c;
            }
        }
    } catch (Exception e) {
        System.debug(LoggingLevel.WARN, 'skipped ' + api + ' -> ' + e.getMessage());
    }
    i++;
}

System.debug('==================================================');
System.debug('SERVICE-ACCOUNT OWNERSHIP SWEEP');
System.debug('objects in scope : ' + targets.size());
System.debug('scanned this run : ' + SKIP + ' -> ' + (i - 1));
System.debug('--------------------------------------------------');
if (findings.isEmpty()) {
    System.debug('Nothing owned by any target account in this slice.');
} else {
    findings.sort();
    for (String s : findings) System.debug('  ' + s);
    System.debug('  SLICE TOTAL : ' + grandTotal);
}
System.debug('--------------------------------------------------');
if (truncated) {
    System.debug('*** INCOMPLETE — re-run with SKIP = ' + i + ' ***');
} else {
    System.debug('Scan complete — all ' + targets.size() + ' objects checked.');
}
System.debug('==================================================');
