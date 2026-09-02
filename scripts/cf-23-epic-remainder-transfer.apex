/*  CF-23 — the rest of what OrgFarm EPIC owns
 *  ------------------------------------------------------------------
 *  CF-04 moved 224 Opportunities and framed the job as done. It was not:
 *  the inventory had been written from the symptom (pipeline value) and
 *  not from the question "what does this user own?".
 *
 *  A sweep of all 187 ownable objects on 02/09/2026, for EPIC, Jack,
 *  Mia, Alan and Lisa, found:
 *      EmailTemplate 13 · Solution 10 · Flow (FlowRecord) 39  = 62
 *  Alan and Lisa: zero, re-verified today.
 *
 *  Also checked, because ownership queries miss them:
 *      dashboards with these as RUNNING USER : 0
 *      scheduled jobs (CronTrigger) owned     : 0
 *      reports / dashboards owned             : 0
 *      list views created by them             : 159 - NOT transferable,
 *          ListView has no OwnerId and is not updateable. They do not
 *          break on a deactivated creator.
 *
 *  Destination: the administrator, same custody logic as CF-04. These
 *  ride the existing custody record and leave with everything else when
 *  custody ends. No second owner category invented for them.
 *
 *  MIXED DML: EmailTemplate is a SETUP object, Solution and Flow are
 *  not. Salesforce refuses both in one transaction, so this runs ONE
 *  object per execution. Set TARGET, run, repeat. Same trap that
 *  silently rolled back the CollaborationGroupMember insert on 29/08.
 *
 *  Set DRY_RUN = false to execute.
 */

Boolean DRY_RUN = false;
String TARGET = 'FlowRecord';   // then 'Solution', then 'FlowRecord'

Id custodian = [SELECT Id FROM User WHERE Name = 'Hemayet Hossain' AND IsActive = true LIMIT 1].Id;
Set<String> names = new Set<String>{'OrgFarm EPIC','Jack Nguyen','Mia Kelly','Alan Brooks','Lisa Fernandez'};
Set<Id> ids = new Map<Id,User>([SELECT Id FROM User WHERE Name IN :names]).keySet();
List<String> objects = new List<String>{TARGET};

Integer grand = 0;
Map<String,Integer> before = new Map<String,Integer>();
for (String o : objects) {
    Integer n = Database.countQuery('SELECT COUNT() FROM ' + o + ' WHERE OwnerId IN :ids');
    before.put(o, n); grand += n;
}
System.debug('=== CF-23 EPIC REMAINDER ===');
System.debug('counts before : ' + before);
System.debug('total to move : ' + grand);

if (DRY_RUN) { System.debug('DRY RUN - nothing written.'); return; }

Integer moved = 0;
for (String o : objects) {
    List<SObject> rows = Database.query('SELECT Id, OwnerId FROM ' + o + ' WHERE OwnerId IN :ids');
    for (SObject r : rows) r.put('OwnerId', custodian);
    if (!rows.isEmpty()) { update rows; moved += rows.size(); }
}
System.debug('moved         : ' + moved);

Map<String,Integer> after = new Map<String,Integer>();
Integer left = 0;
for (String o : objects) {
    Integer n = Database.countQuery('SELECT COUNT() FROM ' + o + ' WHERE OwnerId IN :ids');
    after.put(o, n); left += n;
}
System.debug('counts after  : ' + after);
System.debug('LEFT ON THOSE USERS: ' + left + '   (must be 0)');
