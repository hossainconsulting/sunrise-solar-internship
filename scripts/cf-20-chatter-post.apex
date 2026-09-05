/*  CF-20 / CF-01 - post the result to Chatter
 *  ------------------------------------------------------------------
 *  05/09/2026. Two posts, per sop-escalating-rule-changes.md v1.1:
 *    1. the GROUP post - reaches Marcus, who is Chatter Free and cannot
 *       open records
 *    2. the RECORD post on William J. Kowalski Residence - the audit copy
 *
 *  Recipients verified live before writing this, because CF-22 recurred
 *  twice on exactly that: Marcus Neil 005gK00007HBpc5QAD, active, CsnOnly,
 *  logged in 01/09, and a member of 0F9gK000000YDsTSAW. NOT Marcus Head or
 *  Marcus Lee, both deactivated, both still @mentioned in the 29/08 posts.
 *
 *  SARAH COOPER IS IN THIS GROUP. The drafted note asked Marcus whether to
 *  tell Sarah the corrected number - which would have asked it in front of
 *  her. She is addressed directly instead. That follows Marcus's own
 *  instruction of 02/09: "Tell her before she asks - don't let her find out
 *  from the pack."
 *
 *  ConnectApi is used rather than a raw FeedItem insert so the @mentions
 *  render as live links instead of plain text.
 *
 *  ASCII only.
 */

final Id GROUP_ID  = '0F9gK000000YDsTSAW';
final Id KOWALSKI  = '001gK00001Luv6TQAR';
final Id MARCUS    = '005gK00007HBpc5QAD';
final Id SARAH     = '005gK00007Mpx0NQAR';

// --- guard: never post to a dead recipient again -----------------------
User m = [SELECT Id, Name, IsActive FROM User WHERE Id = :MARCUS];
User s = [SELECT Id, Name, IsActive FROM User WHERE Id = :SARAH];
if (!m.IsActive || !s.IsActive) {
    throw new CalloutException('Refusing to post: ' + m.Name + ' active=' + m.IsActive
                             + ', ' + s.Name + ' active=' + s.IsActive);
}
Integer inGroup = [SELECT COUNT() FROM CollaborationGroupMember
                   WHERE CollaborationGroupId = :GROUP_ID AND MemberId IN (:MARCUS, :SARAH)];
if (inGroup != 2) {
    throw new CalloutException('Refusing to post: expected both in the group, found ' + inGroup);
}

// --- helpers -----------------------------------------------------------
ConnectApi.MessageSegmentInput txt(String s2) {
    ConnectApi.TextSegmentInput t = new ConnectApi.TextSegmentInput();
    t.text = s2;
    return t;
}
ConnectApi.MessageSegmentInput at(Id who) {
    ConnectApi.MentionSegmentInput ms = new ConnectApi.MentionSegmentInput();
    ms.id = who;
    return ms;
}

// --- 1. the group post -------------------------------------------------
ConnectApi.MessageBodyInput body = new ConnectApi.MessageBodyInput();
body.messageSegments = new List<ConnectApi.MessageSegmentInput>();
body.messageSegments.add(at(MARCUS));
body.messageSegments.add(txt(
' - CF-20 is done. All ten pairs, three days early. THE CUSTOMER COUNT IS 48.\n\n'
+ 'Seven pairs are two separate households. Three are the same customer twice: Kowalski, '
+ 'Bennett, Young. 51 accounts less three merges = 48 households. That is a single number, '
+ 'which is what you asked for on 25 August and have not had since.\n\n'
+ 'The six address confirmations are done too. All six were already correct - nothing moved.\n\n'
+ 'THREE MERGES NEED YOUR CALL. Nothing has been merged. Each one throws away a real phone '
+ 'number and I am not choosing which on my own judgement after CF-02. I asked each customer '
+ 'which number reaches them, and they do not point the same way:\n'
+ '  Kowalski - mobile 0410 110 866, so William J. Kowalski Residence survives\n'
+ '  Bennett  - landline (02) 4522 1558, so Liam Bennett Residence survives\n'
+ '  Young    - landline (02) 7306 4534, so Michael Young Residence survives\n'
+ 'My recommendation: the survivor is the record holding the number the customer named, and '
+ 'the discarded number goes into the survivor description BEFORE the merge runs. Salesforce '
+ 'does not keep it. That is exactly how the six addresses were lost in CF-02, and this time '
+ 'we know in advance.\n\n'
+ 'TWO THINGS I GOT WRONG. I ran a day past the date you set on the six calls - two on '
+ 'Thursday, four on Saturday. And none of those six customers named their own suburb: they '
+ 'hesitated, I read out the three options, they picked. That is weaker than it sounds, so '
+ 'each record says prompted rather than confirmed. Say the word if you want any re-done open.\n\n'
+ 'ONE THING THAT WENT THE OTHER WAY. The evidence written on all twenty of those tasks - '
+ 'matching suburb, landline on one record and mobile on the other - finished 3 for 10. '
+ 'Holding the pairs was right. The reason given for holding them was not. If we had treated '
+ 'that pattern as strong enough to merge on, seven real customers would have been collapsed '
+ 'into three and nothing in the org would have shown it afterwards.\n\n'
+ 'THE LICENCE PURCHASE HAS NOT LANDED. You chose buy three on 1 September. Jake still cannot '
+ 'log in, so he cannot own the duplicate queue you rostered him for, cannot receive his own '
+ 'pipeline report, and cannot pick up the standing job you described. Five days. If it is '
+ 'stuck on procurement rather than with you, say so and I will stop listing it as pending.\n\n'));
body.messageSegments.add(at(SARAH));
body.messageSegments.add(txt(
' - you are in this group, so I am telling you directly rather than asking Marcus whether to. '
+ 'You have 41-51 from Tuesday. It is 48. 41 was never reachable: it needed all ten pairs to '
+ 'be duplicates and seven are not. One caveat - until Marcus approves the three merges the '
+ 'org still holds 51 accounts, so a report you run today will say 51, not 48.\n\n'
+ 'Full detail: deliverables/status-note-marcus-cf-01-range-revision.md'));

ConnectApi.FeedItemInput fi = new ConnectApi.FeedItemInput();
fi.subjectId = GROUP_ID;
fi.body = body;
fi.feedElementType = ConnectApi.FeedElementType.FeedItem;
ConnectApi.FeedElement posted = ConnectApi.ChatterFeeds.postFeedElement(null, fi);
System.debug('POST>> group feedItem: ' + posted.id);

// --- 2. the audit copy on the record ----------------------------------
ConnectApi.MessageBodyInput ab = new ConnectApi.MessageBodyInput();
ab.messageSegments = new List<ConnectApi.MessageSegmentInput>();
ab.messageSegments.add(txt(
'AUDIT COPY - 05/09/2026. CF-20 closed, 20 of 20. This pair is ONE household: William '
+ 'Kowalski confirmed both records are his. MERGE CANDIDATE, not merged - survivorship is '
+ 'with Marcus. He named 0410 110 866 as the number that reaches him, so this record is the '
+ 'survivor on his own preference, and (02) 4406 1434 from William Kowalski Residence must be '
+ 'written into the survivor description before any merge runs.\n\n'
+ 'Across all ten pairs: 7 separate households, 3 the same. Customer count 48 once the three '
+ 'merges run. Posted to SunRise Ops - Escalations the same day; that post is the one Marcus '
+ 'receives, this is the audit copy.'));

ConnectApi.FeedItemInput af = new ConnectApi.FeedItemInput();
af.subjectId = KOWALSKI;
af.body = ab;
af.feedElementType = ConnectApi.FeedElementType.FeedItem;
ConnectApi.FeedElement audit = ConnectApi.ChatterFeeds.postFeedElement(null, af);
System.debug('POST>> record feedItem: ' + audit.id);
