/**
 * Ticket 1.2 setup — create the two leavers and give them records to own.
 *
 * Alan and Lisa don't exist in the org yet. Deactivating a user who owns nothing
 * teaches nothing, so this creates them on Salesforce PLATFORM licences (0 of 6
 * used, so this costs no Salesforce licence) and transfers 20 Accounts to each.
 *
 * Run:  sf apex run --target-org sunrise --file seed/week-01-leavers-setup.apex
 *
 * Idempotent: re-running skips users that already exist.
 */

// ── 1. Resolve the Platform profile and the admin's role-free defaults ───────
Profile platformProfile = [
    SELECT Id, Name FROM Profile WHERE Name = 'Standard Platform User' LIMIT 1
];

Set<String> wanted = new Set<String>{
    'alan.brooks@sunrise.hossain.dev',
    'lisa.fernandez@sunrise.hossain.dev'
};

Map<String, User> existing = new Map<String, User>();
for (User u : [SELECT Id, Username, Name FROM User WHERE Username IN :wanted]) {
    existing.put(u.Username, u);
}

List<User> toCreate = new List<User>();

if (!existing.containsKey('alan.brooks@sunrise.hossain.dev')) {
    toCreate.add(new User(
        FirstName        = 'Alan',
        LastName         = 'Brooks',
        Username         = 'alan.brooks@sunrise.hossain.dev',
        Email            = 'hossainconsulting+alan@gmail.com',
        Alias            = 'abrooks',
        CommunityNickname= 'abrooks',
        ProfileId        = platformProfile.Id,
        TimeZoneSidKey   = 'Australia/Sydney',
        LocaleSidKey     = 'en_AU',
        EmailEncodingKey = 'UTF-8',
        LanguageLocaleKey= 'en_US'
    ));
}

if (!existing.containsKey('lisa.fernandez@sunrise.hossain.dev')) {
    toCreate.add(new User(
        FirstName        = 'Lisa',
        LastName         = 'Fernandez',
        Username         = 'lisa.fernandez@sunrise.hossain.dev',
        Email            = 'hossainconsulting+lisa@gmail.com',
        Alias            = 'lfernan',
        CommunityNickname= 'lfernan',
        ProfileId        = platformProfile.Id,
        TimeZoneSidKey   = 'Australia/Sydney',
        LocaleSidKey     = 'en_AU',
        EmailEncodingKey = 'UTF-8',
        LanguageLocaleKey= 'en_US'
    ));
}

if (!toCreate.isEmpty()) {
    insert toCreate;
    System.debug('Created ' + toCreate.size() + ' user(s) on ' + platformProfile.Name);
} else {
    System.debug('Both users already exist - skipping creation.');
}

// ── 2. Give them something to own ────────────────────────────────────────────
// Deliberately NOT using Mass Transfer here. Mass Transfer is the tool you use
// to transfer records OFF a leaver in the real ticket; this is just seeding.

Map<String, Id> ownerByUsername = new Map<String, Id>();
for (User u : [SELECT Id, Username FROM User WHERE Username IN :wanted]) {
    ownerByUsername.put(u.Username, u.Id);
}

Id alanId = ownerByUsername.get('alan.brooks@sunrise.hossain.dev');
Id lisaId = ownerByUsername.get('lisa.fernandez@sunrise.hossain.dev');

List<Account> pool = [
    SELECT Id, OwnerId FROM Account
    WHERE OwnerId != :alanId AND OwnerId != :lisaId
    ORDER BY CreatedDate
    LIMIT 40
];

List<Account> toMove = new List<Account>();
for (Integer i = 0; i < pool.size(); i++) {
    Account a = pool[i];
    a.OwnerId = (i < 20) ? alanId : lisaId;
    toMove.add(a);
}

if (!toMove.isEmpty()) {
    update toMove;
}

// ── 3. Report the starting position for the ticket ───────────────────────────
for (AggregateResult ar : [
    SELECT Owner.Name owner, COUNT(Id) total FROM Account GROUP BY Owner.Name
]) {
    System.debug(ar.get('owner') + ': ' + ar.get('total') + ' Accounts');
}
