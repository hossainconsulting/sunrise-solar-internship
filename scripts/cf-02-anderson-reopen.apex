/*  CF-02 — reopen Andrew J. Anderson Residence
 *  ------------------------------------------------------------------
 *  03/09/2026. Three flags were cleared this evening (Anderson 21:18,
 *  Murphy 21:28, Fitzgerald 21:49) and three tasks marked Completed.
 *  Confirmed with Hemayet: only TWO calls were made — Fitzgerald and
 *  Murphy. Anderson was cleared without customer contact.
 *
 *  Evidence it was not called: the task comment records phone
 *  0410 364 274, which is MURPHY's number, not Anderson's
 *  (0411 029 470) — the entry was pasted from the Murphy task. The
 *  suburb, postcode and both either/or placeholders are unfilled and
 *  the account address is unchanged since the 25/08 merge.
 *
 *  This restores the control. It does NOT delete the bogus comment:
 *  the record of what happened stays in the record, same as 29/08.
 *
 *  Murphy and Fitzgerald are left alone here — they were called, and
 *  their comments need the real detail written in, not a reversal.
 */

Id acctId = '001gK00001Luv8LQAR';   // Andrew J. Anderson Residence
Id taskId = '00TgK00000BTQVRUA5';

String note =
  '\n\n03/09/2026 — CLEARED WITHOUT A CALL, AND REVERSED.\n'
+ 'This task was marked Completed and Service_Address_Unconfirmed__c was cleared at '
+ '21:18 on 03/09/2026. No call was made to this customer. The comment appended above '
+ 'was a template pasted from the Oliver J. Murphy task: it carries Murphy\'s phone '
+ 'number (0410 364 274) rather than Anderson\'s (0411 029 470), and leaves the suburb, '
+ 'postcode and both either/or choices unfilled. No address was changed on the account.\n'
+ 'Reopened and the flag re-set the same evening. THE SERVICE ADDRESS ON THIS ACCOUNT '
+ 'IS STILL UNCONFIRMED. Candidates from the 25/08 merge: Campbelltown 2560 (currently '
+ 'held, 2 of 4 records), Penrith 2750, Chatswood 2067. Ring 0411 029 470, or the pair '
+ 'partner landline (02) 4290 1310.';

Account a = [SELECT Id, Service_Address_Unconfirmed__c FROM Account WHERE Id = :acctId];
a.Service_Address_Unconfirmed__c = true;
update a;

Task t = [SELECT Id, Status, Description FROM Task WHERE Id = :taskId];
t.Status = 'Not Started';
t.Description = t.Description + note;
update t;

System.debug('AND>> account flag  : ' + [SELECT Service_Address_Unconfirmed__c FROM Account WHERE Id = :acctId].Service_Address_Unconfirmed__c);
System.debug('AND>> task status   : ' + [SELECT Status FROM Task WHERE Id = :taskId].Status);
System.debug('AND>> desc length   : ' + [SELECT Description FROM Task WHERE Id = :taskId].Description.length());
