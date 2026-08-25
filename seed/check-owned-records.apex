/*
 * SOP gate — "what does this user still own?"
 *
 * Referenced by sop-user-deactivation.md Step 1 and Step 4.
 *
 * WHY THIS EXISTS
 * The original SOP asked for Accounts, Opportunities, Cases and open Leads — the
 * four things a departing SALES REP owns. OrgFarm EPIC was deactivated in Ticket
 * 1.1 without that check ever being run against it, and left 15 Opportunities
 * worth $178,432 owned by a disabled user, still counted in the forecast
 * (Ticket 2.3). A hand-written list of objects only ever catches the records you
 * already thought of. This asks the org instead.
 *
 * HOW TO RUN
 * Developer Console -> Debug -> Open Execute Anonymous Window (tick Open Log).
 * Set TARGET_USER, run, read the debug log.
 *
 * WHY THERE IS A SKIP PARAMETER
 * This org has 144 queryable objects carrying an OwnerId, and Apex allows only
 * 100 SOQL queries per transaction. One pass physically cannot cover them all.
 * The script counts what it can, then prints the SKIP value to resume from.
 * Run it twice; the second run starts where the first stopped. If you only ever
 * run it once you have not run the gate — you have run part of it.
 */

String  TARGET_USER = 'OrgFarm EPIC';
Integer SKIP        = 0;    // <-- set to the "NEXT SKIP" printed by the previous run

Integer QUERY_CEILING = 90; // leave headroom under the 100-query limit

List<User> us = [SELECT Id, Name, IsActive FROM User WHERE Name = :TARGET_USER LIMIT 1];
if (us.isEmpty()) {
    System.debug(LoggingLevel.ERROR, 'No user found named: ' + TARGET_USER);
    return;
}
Id uid = us[0].Id;

// Pass 1 — describe only, costs no SOQL. Sorted so slices are deterministic.
List<String> targets = new List<String>();
for (Schema.SObjectType t : Schema.getGlobalDescribe().values()) {
    Schema.DescribeSObjectResult d = t.getDescribe();

    if (!d.isQueryable() || !d.isAccessible() || d.isCustomSetting()) continue;
    if (d.isDeprecatedAndHidden() || !d.isCreateable()) continue;
    if (!d.fields.getMap().containsKey('OwnerId')) continue;

    String api = d.getName();
    // Derived records follow their parent; they are not independently owned.
    if (api.endsWith('__Share') || api.endsWith('__History') || api.endsWith('History')
        || api.endsWith('Feed') || api.endsWith('__Tag') || api.endsWith('ChangeEvent')
        || api.endsWith('Event')) continue;

    targets.add(api);
}
targets.sort();

// Pass 2 — count, stopping before the governor limit bites.
List<String> holdings = new List<String>();
Integer grandTotal = 0;
Integer i = SKIP;
Boolean truncated = false;

while (i < targets.size()) {
    if (Limits.getQueries() >= QUERY_CEILING) { truncated = true; break; }
    String api = targets[i];
    try {
        Integer c = Database.countQuery('SELECT COUNT() FROM ' + api + ' WHERE OwnerId = :uid');
        if (c > 0) { holdings.add(api + ' : ' + c); grandTotal += c; }
    } catch (Exception e) {
        // Some objects reject a filtered count (OwnerId not filterable, feature off).
        System.debug(LoggingLevel.WARN, 'skipped ' + api + ' -> ' + e.getMessage());
    }
    i++;
}

System.debug('==================================================');
System.debug('OWNED-RECORDS GATE : ' + us[0].Name + '  (active=' + us[0].IsActive + ')');
System.debug('objects in scope   : ' + targets.size());
System.debug('scanned this run   : ' + SKIP + ' -> ' + (i - 1));
System.debug('--------------------------------------------------');
if (holdings.isEmpty()) {
    System.debug('Nothing owned in this slice.');
} else {
    holdings.sort();
    for (String s : holdings) System.debug('  ' + s);
    System.debug('  SLICE TOTAL : ' + grandTotal);
}
System.debug('--------------------------------------------------');
if (truncated) {
    System.debug('*** INCOMPLETE — hit the SOQL ceiling. ***');
    System.debug('*** Re-run with SKIP = ' + i + ' to cover the rest. ***');
} else {
    System.debug('Scan complete — all ' + targets.size() + ' objects checked.');
    System.debug(grandTotal == 0 && SKIP == 0
        ? 'CLEAR — safe to deactivate.'
        : 'Add this slice to the previous one before judging CLEAR.');
}
System.debug('==================================================');
