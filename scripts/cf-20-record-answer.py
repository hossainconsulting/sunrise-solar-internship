"""Record one CF-20 pair's answer onto both its HOLD tasks and close them.

Set PAIR and OUTCOME, run, then run the generated .apex. Written for the four
pairs still open on 05/09/2026 - Kowalski, Bennett, Young, Singh - so the next
three are a two-line edit rather than a fresh script.

Answers are typed here and written by script deliberately. Every defect in CF-02
since 03/09 entered through the Task Comments box by hand: a paste landing
mid-line, a wrong surname, a mangled em dash, and both branches of a worked
example pasted in so each line asserted its own opposite.

ASCII only - the CLI path turns a UTF-8 em dash into mojibake.
"""
import json, pathlib, subprocess, sys

PAIR    = "Singh"
OUTCOME = "separate"      # "same" or "separate"
SPOKE   = "Ryan Singh"
RANG    = None            # which number actually connected, if known. None = do not claim one.
DATE    = "05/09/2026"

PREFERRED    = "(02) 6262 3418"
PREFERRED_ON = "Ryan Singh Residence (001gK00001Luv55QAB), the landline record"
DISCARDED    = "0410 300 922 on Ryan J. Singh Residence (001gK00001Luv6rQAB)"

TALLY = ("CF-20 IS NOW COMPLETE: all 10 pairs answered - 7 separate households, 3 the "
         "same (Kowalski, Bennett, Young). The 'complementary phone formats' evidence in "
         "the text above finished 3 for 10. It was the stated reason all twenty of these "
         "tasks existed, and it was wrong more often than right. Holding the pairs was "
         "correct; the evidence given for holding them was not.\r\n"
         "Customer count: 51 accounts less 3 merges = 48 households, once the three "
         "merges are approved and run. A single number for the first time since 25/08.")

PAIRS = {   # pair -> (J. task, landline task, address)
    "Kowalski": ("00TgK00000BTRUkUAP", "00TgK00000BTRUjUAP", "155 Kurrajong Dr, Maitland 2320"),
    "Bennett":  ("00TgK00000BTRUmUAP", "00TgK00000BTRUlUAP", "199 Mill Lane, Wollongong 2500"),
    "Young":    ("00TgK00000BTRUqUAP", "00TgK00000BTRUpUAP", "155 Kurrajong Dr, Belmont 2280"),
    "Singh":    ("00TgK00000BTRUsUAP", "00TgK00000BTRUrUAP", "199 Mill Lane, Wollongong 2500"),
}

SAME = (
    "\r\n\r\n--- Answered {date} ---\r\n"
    "{rang}Spoke to {spoke}. Confirms BOTH records are the same household - one customer, "
    "two records from the 17/08 load, both at {addr}.\r\n"
    "{pref}"
    "MERGE CANDIDATE. NOT merged on this call: the survivorship choice goes to Marcus "
    "before anything irreversible, same as the CF-13 Contact rule. The two records differ "
    "on phone only - landline on one, mobile on the other - and the discarded number must "
    "be written to the survivor before the merge, or it is lost the way the six bucket-C "
    "addresses were.\r\n"
    "Consequence for CF-01: this pair reduces the customer count by one.\r\n"
    "{tally}")

PREF_BLOCK = (
    "Preferred contact number, given by the customer: {pref}, held on {on}.\r\n"
    "SURVIVORSHIP: on the customer's stated preference the natural survivor is that "
    "record, and {disc} is the number to preserve in its Description before any merge.\r\n"
    "Note the basis. Every survivorship decision in this org before this week rested on "
    "record age - which is what produced CF-02's six unconfirmed addresses and what the "
    "CF-13 rule had to declare arbitrary. These rest on the customer saying which number "
    "reaches them. AND THEY DO NOT POINT THE SAME WAY: Kowalski named the mobile, on the "
    "'J.' record; Bennett and Young named the landline, on the plain record. Two out of "
    "three is not a rule - it is a tally - and there is no blanket survivorship to apply "
    "here. It is per pair, on what the customer said.\r\n")

SEPARATE = (
    "\r\n\r\n--- Answered {date} ---\r\n"
    "{rang}Spoke to {spoke}. The two records are NOT the same household - two separate "
    "customers at {addr}. DO NOT MERGE this pair.\r\n"
    "{pref}"
    "Consequence for CF-01: this pair contributes no reduction to the customer count.\r\n"
    "{tally}")

def apex_escape(s):
    return (s.replace("\\", "\\\\").replace("'", "\\'")
             .replace("\r", "\\r").replace("\n", "\\n"))

if PAIR not in PAIRS:
    sys.exit("unknown pair: %s" % PAIR)
if OUTCOME not in ("same", "separate"):
    sys.exit("OUTCOME must be 'same' or 'separate'")

# A preferred number means different things depending on the outcome. On a merge it
# is the survivorship signal. On a separate pair there is no merge and no survivor -
# it is one household's contact detail, and saying "SURVIVORSHIP" on a pair marked DO
# NOT MERGE would contradict the line above it.
PREF_BLOCK_SEPARATE = (
    "Contact number given by the person spoken to: {pref}, which is the number held on "
    "{on}.\r\n"
    "NO survivorship implication - this pair is not merging. Recorded as a contact "
    "detail only.\r\n"
    "LIMITATION worth stating: this pair was resolved on one household's word. The other "
    "record, {disc}, is a different customer who has not themselves been contacted, and "
    "their details remain unverified. That is sufficient for the question CF-20 asked - "
    "one household or two - and it is not a confirmation of the second household's "
    "details. The same is true of the six pairs answered earlier as separate.\r\n")

t1, t2, addr = PAIRS[PAIR]
# Only claim a dialled number if one was actually supplied. Anderson's CF-02 comment
# ended up carrying Murphy's phone number because a detail was filled in rather than known.
rang = ("Rang %s. " % RANG) if RANG else ""
_pb = PREF_BLOCK if OUTCOME == "same" else PREF_BLOCK_SEPARATE
pref = _pb.format(pref=PREFERRED, on=PREFERRED_ON, disc=DISCARDED) if PREFERRED else ""
block = (SAME if OUTCOME == "same" else SEPARATE).format(
    date=DATE, rang=rang, spoke=SPOKE, addr=addr, pref=pref, tally=TALLY)

if not block.isascii():
    sys.exit("refusing: non-ASCII in the text to be written")

exe = "sf.cmd" if sys.platform == "win32" else "sf"
r = subprocess.run([exe, "data", "query", "-o", "sunrise", "-q",
                    "SELECT Id, What.Name, Status, Description FROM Task WHERE Id IN ('%s','%s')"
                    % (t1, t2), "-r", "json"], capture_output=True, text=True)
if r.stdout.find("{") < 0:
    sys.exit("query failed: %s" % (r.stderr or r.stdout)[:300])
recs = json.loads(r.stdout[r.stdout.find("{"):])["result"]["records"]
if len(recs) != 2:
    sys.exit("expected 2 tasks, got %d" % len(recs))

lines = ["// GENERATED by cf-20-record-answer.py - %s, outcome: %s" % (PAIR, OUTCOME),
         "List<Task> ups = new List<Task>();", ""]
CLOSED_EMPTY = (
    "\r\n\r\n--- Closed without the answer, {when} ---\r\n"
    "This task was set to Completed with nothing recorded: the description was unchanged "
    "from the 25/08 original and carried no outcome. The answer below was supplied "
    "separately and written here afterwards. Noted rather than tidied away, because a task "
    "closed empty is the CF-02 failure of 29/08 - the control answered by clearing it - "
    "arriving on CF-20.")

for rec in recs:
    desc = rec["Description"] or ""
    if "--- Answered" in desc:
        sys.exit("refusing: %s already carries an answer" % rec["What"]["Name"])
    d = desc
    if rec["Status"] == "Completed":
        # Closed in the UI with no outcome written. Record that, then add the answer.
        d += CLOSED_EMPTY.format(when=DATE)
    d += block
    lines += ["// %s" % rec["What"]["Name"],
              "ups.add(new Task(Id='%s', Status='Completed', Description='%s'));"
              % (rec["Id"], apex_escape(d)), ""]
lines += ["update ups;", "System.debug('CF20>> %s updated: ' + ups.size());" % PAIR]

out = pathlib.Path(__file__).with_name("cf-20-answer-%s.apex" % PAIR.lower())
out.write_text("\n".join(lines), encoding="utf-8")
print("wrote %s - %s: %s household, 2 tasks" % (out.name, PAIR, OUTCOME))
