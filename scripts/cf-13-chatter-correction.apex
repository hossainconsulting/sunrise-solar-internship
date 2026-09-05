/*  Correction comment on the 10:34 post to Marcus
 *  ------------------------------------------------------------------
 *  05/09/2026. The post 0D5gK00000VRVNdSAP asked Marcus for three
 *  decisions. Two are wrong as written:
 *
 *  Item 2 said "Jake still can't log in". True when posted at 20:34;
 *  Jake Mathewson was created 20:46 and logged in 20:47. He is now
 *  reachable AND still unable to do the job, which is a different
 *  statement and matters - Marcus seeing Jake in the group could
 *  reasonably conclude the licence arrived. It has not: Salesforce
 *  reads 4 of 4.
 *
 *  Item 3 asked for a decision on CF-13 Bucket A. Bucket A was MERGED
 *  on 01/09 - Contacts 137 -> 98, and all 16 survivors carry their
 *  discarded phone numbers in Description. The held bucket is B: 21
 *  groups, 79 Contacts, address conflict. The error originated in an
 *  incorrect summary from this agent and was posted in good faith.
 *
 *  Posted as a COMMENT on that post rather than a new one, so the
 *  correction sits with the thing it corrects.
 *
 *  ASCII only.
 */

final Id POST_ID = '0D5gK00000VRVNdSAP';
final Id MARCUS  = '005gK00007HBpc5QAD';

FeedItem fi = [SELECT Id, ParentId FROM FeedItem WHERE Id = :POST_ID];
User m = [SELECT Id, IsActive FROM User WHERE Id = :MARCUS];
if (!m.IsActive) throw new CalloutException('Refusing: Marcus Neil is not active');

// verified before writing: 98 Contacts, 21 duplicate groups remaining, 16 merge
// survivors carrying a Description. Bucket A is done.
Integer contacts = [SELECT COUNT() FROM Contact];
if (contacts != 98) throw new CalloutException(
    'Refusing: expected 98 Contacts post-Bucket-A, found ' + contacts
  + '. Re-check before claiming Bucket A is merged.');

ConnectApi.MessageSegmentInput txt(String s) {
    ConnectApi.TextSegmentInput t = new ConnectApi.TextSegmentInput(); t.text = s; return t;
}
ConnectApi.MessageSegmentInput at(Id who) {
    ConnectApi.MentionSegmentInput ms = new ConnectApi.MentionSegmentInput(); ms.id = who; return ms;
}

ConnectApi.CommentInput ci = new ConnectApi.CommentInput();
ci.body = new ConnectApi.MessageBodyInput();
ci.body.messageSegments = new List<ConnectApi.MessageSegmentInput>();
ci.body.messageSegments.add(at(MARCUS));
ci.body.messageSegments.add(txt(
' - correcting two of the three above. Both are mine, both same day, and item 1 stands.\n\n'
+ 'ITEM 2, JAKE - overtaken 12 minutes after I posted it. Jake Mathewson has an account and '
+ 'logged in at 20:47. He is in this group now. But he is on a CHATTER FREE licence, so '
+ 'nothing above actually unblocks: he cannot open a Duplicate Record Set, so CF-07 stays '
+ 'with me, and he cannot open a report, so 2.3 stays where it is. "Jake cannot log in" is '
+ 'no longer the right description - "Jake can log in and still cannot work" is. THE THREE '
+ 'SALESFORCE LICENCES YOU APPROVED ON 1 SEPTEMBER ARE STILL NOT HERE: the org reads 4 of 4 '
+ 'tonight. Flagging that because seeing Jake appear in this group would reasonably suggest '
+ 'the purchase landed, and it has not. My stopgap stands - I keep the Monday queue.\n\n'
+ 'ITEM 3, CF-13 - the ask is wrong and the mistake is mine. BUCKET A IS ALREADY DONE. Its '
+ '16 groups were merged on 1 September: Contacts went 137 to 98, and all 16 surviving '
+ 'records carry their discarded phone numbers written into the Description, so nothing was '
+ 'lost. Nothing about Bucket A is waiting on you.\n\n'
+ 'What IS waiting on you is BUCKET B: 21 groups, 79 Contacts. Held because one email '
+ 'address has two different mailing addresses on it and nothing in the org says which is '
+ 'right. The decision is yours either way: hold them until someone rings those customers, '
+ 'or merge and accept losing 21 addresses. That second option is the same trade that '
+ 'produced the six unconfirmed service addresses I spent this week ringing people about, '
+ 'which is why I would rather you took it deliberately than inherited it.\n\n'
+ 'Same Friday deadline as before, now against the right bucket.'));

ConnectApi.Comment posted = ConnectApi.ChatterFeeds.postCommentToFeedElement(null, POST_ID, ci, null);
System.debug('CORR>> comment id: ' + posted.id);
