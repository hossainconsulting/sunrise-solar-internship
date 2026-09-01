/*  CF-13 — Contact merge, Bucket A only
 *  ------------------------------------------------------------------
 *  Approved by Marcus Neil, FeedComment 0D7gK000000CH3VSAW, 01/09/2026:
 *    "Approved as proposed. Merge the 16, hold the 21. Do not merge the
 *     21 to tidy the number up."
 *
 *  RULE (deliverables/cf-13-contact-merge-rule.md):
 *    - Match key      : exact Email. 37 of 37 groups match exactly.
 *    - Bucket A       : every record in the group shares one mailing
 *                       address. Differ only by phone. MERGE.
 *    - Bucket B       : two or more mailing addresses in the group.
 *                       HOLD - picking an address without evidence is
 *                       how CF-02's six unconfirmed addresses happened.
 *    - Survivor       : oldest CreatedDate, then Id. ARBITRARY, and
 *                       declared arbitrary - the records were created in
 *                       the same second by the seed load, so record age
 *                       carries no meaning. It is a tiebreak, not
 *                       evidence. Cases reparent to the survivor
 *                       automatically, so nothing is at risk in the
 *                       choice.
 *    - Preservation   : every discarded phone number is written into the
 *                       survivor's Description BEFORE the merge runs, so
 *                       it survives on the record and not only in a CSV.
 *
 *  Set DRY_RUN = false to execute. Leave true to report and change nothing.
 */

Boolean DRY_RUN = true;

Map<String, List<Contact>> byEmail = new Map<String, List<Contact>>();
for (Contact c : [SELECT Id, Email, Phone, MailingStreet, MailingCity, Description, CreatedDate
                  FROM Contact WHERE Email != null ORDER BY CreatedDate, Id]) {
    if (!byEmail.containsKey(c.Email)) byEmail.put(c.Email, new List<Contact>());
    byEmail.get(c.Email).add(c);
}

List<Contact> mastersToUpdate = new List<Contact>();
Map<Id, List<Contact>> losersByMaster = new Map<Id, List<Contact>>();
Integer groupsA = 0, groupsB = 0, singles = 0, toRemove = 0;

for (String email : byEmail.keySet()) {
    List<Contact> g = byEmail.get(email);
    if (g.size() == 1) { singles++; continue; }

    Set<String> addresses = new Set<String>();
    for (Contact c : g) addresses.add(c.MailingStreet + '|' + c.MailingCity);
    if (addresses.size() > 1) { groupsB++; continue; }   // Bucket B - HOLD

    groupsA++;
    Contact master = g[0];                               // oldest, arbitrary
    List<Contact> losers = new List<Contact>();
    List<String> discardedPhones = new List<String>();
    for (Integer i = 1; i < g.size(); i++) {
        losers.add(g[i]);
        if (g[i].Phone != null && g[i].Phone != master.Phone) discardedPhones.add(g[i].Phone);
    }
    toRemove += losers.size();

    String note = '\n\n--- CF-13 merge 01/09/2026 ---\n'
        + 'This record survived a merge of ' + g.size() + ' duplicate Contacts sharing the '
        + 'email ' + email + '. They were identical but for phone number and were created in '
        + 'the same second by the 17/08/2026 seed load.\n'
        + 'Survivor chosen by oldest CreatedDate. THAT CHOICE WAS ARBITRARY and is recorded '
        + 'as such - record age carries no meaning here.\n'
        + 'Phone retained: ' + master.Phone + '\n'
        + 'Phone numbers discarded by the merge: ' + String.join(discardedPhones, ', ') + '\n'
        + 'Rule and approval: deliverables/cf-13-contact-merge-rule.md, '
        + 'FeedComment 0D7gK000000CH3VSAW.';

    master.Description = (master.Description == null ? '' : master.Description) + note;
    mastersToUpdate.add(master);
    losersByMaster.put(master.Id, losers);
}

System.debug('=== CF-13 BUCKET A ===');
System.debug('singleton groups (no duplicate) : ' + singles);
System.debug('Bucket A groups to merge        : ' + groupsA);
System.debug('Bucket B groups HELD            : ' + groupsB);
System.debug('records to be removed           : ' + toRemove);
System.debug('Contacts before                 : ' + [SELECT COUNT() FROM Contact]);
System.debug('Cases before                    : ' + [SELECT COUNT() FROM Case WHERE ContactId != null]);

if (DRY_RUN) {
    System.debug('DRY RUN - nothing written. Set DRY_RUN = false to execute.');
    return;
}

// 1. preserve the discarded phones on the survivor, before anything is destroyed
update mastersToUpdate;
System.debug('survivor Descriptions updated   : ' + mastersToUpdate.size());

// 2. merge. Apex merges a master plus at most 2 records per call.
Integer merges = 0;
for (Id masterId : losersByMaster.keySet()) {
    List<Contact> losers = losersByMaster.get(masterId);
    for (Integer i = 0; i < losers.size(); i += 2) {
        List<Contact> chunk = new List<Contact>();
        chunk.add(losers[i]);
        if (i + 1 < losers.size()) chunk.add(losers[i + 1]);
        merge new Contact(Id = masterId) chunk;
        merges++;
    }
}

System.debug('merge operations executed       : ' + merges);
System.debug('Contacts after                  : ' + [SELECT COUNT() FROM Contact]);
System.debug('Cases after                     : ' + [SELECT COUNT() FROM Case WHERE ContactId != null]);
