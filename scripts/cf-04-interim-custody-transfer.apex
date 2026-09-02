/*  CF-04 — Interim custodianship transfer
 *  ------------------------------------------------------------------
 *  Approved by Marcus Neil, FeedComment 0D7gK000000CH3VSAW, 01/09/2026:
 *    "Jake inherits all 666, the moment his licence lands. Until then
 *     hold them under your name as declared custodian, written down -
 *     I don't want to discover in November that the admin quietly owns
 *     the pipeline."
 *
 *  Moves every Opportunity owned by OrgFarm EPIC (deactivated), Jack
 *  Nguyen and Mia Kelly to the administrator, as declared temporary
 *  custodian. Declared in deliverables/cf-04-interim-custodianship.md.
 *
 *  END CONDITION: all 666 transfer to Jake the day his Salesforce
 *  licence is provisioned. Review 30/09/2026 if that has not happened.
 *
 *  REVERSIBLE: evidence/week-02/cf-04-pre-custody-ownership.csv holds
 *  the original owner of all 890 Opportunities.
 *
 *  Set DRY_RUN = false to execute.
 */

Boolean DRY_RUN = false;

Id custodian = [SELECT Id FROM User WHERE Name = 'Hemayet Hossain' AND IsActive = true LIMIT 1].Id;
Set<String> fromOwners = new Set<String>{'OrgFarm EPIC', 'Jack Nguyen', 'Mia Kelly'};

List<Opportunity> toMove = [SELECT Id, OwnerId, Owner.Name, Amount, IsClosed
                            FROM Opportunity WHERE Owner.Name IN :fromOwners];

Map<String, Integer> byOwner = new Map<String, Integer>();
Integer openCount = 0;
Decimal openValue = 0;
for (Opportunity o : toMove) {
    String n = o.Owner.Name;
    byOwner.put(n, (byOwner.containsKey(n) ? byOwner.get(n) : 0) + 1);
    if (!o.IsClosed) { openCount++; if (o.Amount != null) openValue += o.Amount; }
}

System.debug('=== CF-04 INTERIM CUSTODY ===');
System.debug('custodian                : Hemayet Hossain (' + custodian + ')');
System.debug('Opportunities to move    : ' + toMove.size());
System.debug('by current owner         : ' + byOwner);
System.debug('of which OPEN            : ' + openCount + '  worth $' + openValue);
System.debug('admin owns before        : ' + [SELECT COUNT() FROM Opportunity WHERE OwnerId = :custodian]);

if (DRY_RUN) {
    System.debug('DRY RUN - nothing written. Set DRY_RUN = false to execute.');
    return;
}

for (Opportunity o : toMove) { o.OwnerId = custodian; }
update toMove;

System.debug('transferred              : ' + toMove.size());
System.debug('admin owns after         : ' + [SELECT COUNT() FROM Opportunity WHERE OwnerId = :custodian]);
System.debug('left on EPIC/Jack/Mia    : ' + [SELECT COUNT() FROM Opportunity WHERE Owner.Name IN :fromOwners] + '  (must be 0)');
