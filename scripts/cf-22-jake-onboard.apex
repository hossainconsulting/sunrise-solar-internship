/*  CF-22 - add Jake Mathewson to the escalation group and orient him
 *  ------------------------------------------------------------------
 *  05/09/2026. Jake Mathewson (005gK00007VGhKTQA1) was created at 20:46
 *  and logged in at 20:47 - a proven login on a real mailbox. He is the
 *  last of the four people named across the deliverables (Marcus 139
 *  mentions, Jake 75, Zara 28, Sarah 20) to become reachable at all.
 *
 *  He is CHATTER FREE, not Salesforce. Salesforce is still 4 of 4; the
 *  "buy three" purchase Marcus approved on 01/09 has not landed. So this
 *  makes him CONTACTABLE and nothing more:
 *      - CF-07, the duplicate queue he is rostered for: still blocked,
 *        a Chatter Free user cannot open a Duplicate Record Set
 *      - Ticket 2.3's pipeline report: still blocked, he cannot open a
 *        report at all
 *  The orientation post says that to him in plain terms rather than
 *  letting him discover it, which is the CF-22 lesson.
 *
 *  Membership is INSERTED, not requested. Sarah's request sat Pending and
 *  the group rendered "only members can see updates" with no post box -
 *  the third time a channel looked built and reached nobody.
 *
 *  ASCII only.
 */

final Id GROUP_ID = '0F9gK000000YDsTSAW';
final Id JAKE     = '005gK00007VGhKTQA1';

// --- guards ------------------------------------------------------------
User j = [SELECT Id, Name, IsActive, UserType, LastLoginDate FROM User WHERE Id = :JAKE];
if (!j.IsActive) throw new CalloutException('Refusing: ' + j.Name + ' is not active');
if (j.LastLoginDate == null) throw new CalloutException(
    'Refusing: ' + j.Name + ' has never logged in. An account that has not been used is '
  + 'the Marcus Head state - built and unproven.');

Integer already = [SELECT COUNT() FROM CollaborationGroupMember
                   WHERE CollaborationGroupId = :GROUP_ID AND MemberId = :JAKE];

if (already == 0) {
    insert new CollaborationGroupMember(
        CollaborationGroupId = GROUP_ID, MemberId = JAKE, CollaborationRole = 'Standard');
    System.debug('JAKE>> added to group');
} else {
    System.debug('JAKE>> already a member, not re-added');
}

// --- verify membership BEFORE posting ----------------------------------
Integer now = [SELECT COUNT() FROM CollaborationGroupMember
               WHERE CollaborationGroupId = :GROUP_ID AND MemberId = :JAKE];
if (now != 1) throw new CalloutException('Refusing to post: membership did not take');

// --- orientation post, mentioning him so it reaches him ----------------
ConnectApi.MessageSegmentInput txt(String s) {
    ConnectApi.TextSegmentInput t = new ConnectApi.TextSegmentInput(); t.text = s; return t;
}
ConnectApi.MessageSegmentInput at(Id who) {
    ConnectApi.MentionSegmentInput m = new ConnectApi.MentionSegmentInput(); m.id = who; return m;
}

ConnectApi.MessageBodyInput body = new ConnectApi.MessageBodyInput();
body.messageSegments = new List<ConnectApi.MessageSegmentInput>();
body.messageSegments.add(at(JAKE));
body.messageSegments.add(txt(
' - welcome, and read this before you go looking for anything.\n\n'
+ 'YOU HAVE A CHATTER FREE LICENCE. That means you can read this group, reply here, and be '
+ 'mentioned. It does NOT let you open an Account, an Opportunity, a Case, or any report. '
+ 'If you click a record link in here it will not open. That is the licence, not a '
+ 'permissions mistake, and telling you now beats you finding out mid-job.\n\n'
+ 'WHAT THIS MEANS FOR THE TWO THINGS ALREADY ASSIGNED TO YOU:\n'
+ '1. The duplicate queue - Marcus rostered you for ten minutes every Monday. You cannot '
+ 'do it yet. A Duplicate Record Set is a record and your licence cannot open one. It stays '
+ 'with me until a Salesforce licence arrives.\n'
+ '2. Your pipeline report - same. You cannot open a report. It currently emails Jack '
+ 'Nguyen and Mia Kelly, neither of whom has ever logged in, which is its own problem.\n\n'
+ 'WHAT IS ACTUALLY WAITING ON THE LICENCE. Marcus approved buying three on 1 September. '
+ 'They have not arrived - Salesforce is still 4 of 4 today. Until then you are reachable '
+ 'but you cannot work in the org.\n\n'
+ 'WHAT YOU CAN USEFULLY DO NOW: answer things here. Two live examples - I have three '
+ 'Contact merges waiting on a survivorship decision, and there are 21 Contact groups held '
+ 'because one email has two different mailing addresses and nothing in the org says which '
+ 'is right. Those need someone who knows the customers, not someone who knows the buttons.\n\n'
+ 'One thing worth knowing about this group: every escalation written in Weeks 1 and 2 was '
+ 'addressed to a channel that reached nobody, because none of you had accounts. You are '
+ 'the last of the four to get one. If something in here reads as though it assumes you '
+ 'already knew it, that is why - say so and I will fill in the gap.'));

ConnectApi.FeedItemInput fi = new ConnectApi.FeedItemInput();
fi.subjectId = GROUP_ID;
fi.body = body;
fi.feedElementType = ConnectApi.FeedElementType.FeedItem;
ConnectApi.FeedElement posted = ConnectApi.ChatterFeeds.postFeedElement(null, fi);
System.debug('JAKE>> orientation feedItem: ' + posted.id);
