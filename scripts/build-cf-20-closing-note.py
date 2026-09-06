"""Generate cf-20-closing-note.apex - append the final result to all 20 CF-20 tasks.

07/09/2026. CF-20 closed on 05/09 with all ten pairs answered, but every one of the
twenty task records still carries its original EVIDENCE paragraph asserting that
complementary phone formats are "consistent with two import sources for the same
customer" and that the pattern "holds on all 10 pairs".

The exercise refuted that. The pattern was present on all 10 pairs and predicted the
right answer on 3. Eight of the twenty tasks carry a running tally written at the
moment they were answered (1 for 7, 2 for 8, 3 for 9, 3 for 10); twelve carry none,
and no task carries the final figure. So twenty closed records assert an evidence
claim their own answers disproved.

This appends a closing note. It does NOT edit the original paragraph: the register's
practice throughout is to strike a wrong claim visibly rather than delete it, because
a quietly corrected document loses the finding. The note names the paragraph it is
correcting so the two are read together.

Verdicts are not hardcoded from a document - they are derived from each task's own
"--- Answered ---" section in the org and cross-checked against the running tallies.

ASCII only throughout: the CLI path mangles non-ASCII into mojibake.
"""
import json, pathlib, re, subprocess, sys

HERE = pathlib.Path(__file__).parent
OUT = HERE / "cf-20-closing-note.apex"
ORG = "sunrise"

SAME = {"Kowalski", "Bennett", "Young"}
SEPARATE = {"Anderson", "Clark", "Patel", "Tran", "Fitzgerald", "Murphy", "Singh"}

MARKER = "--- CF-20 closed 07/09/2026"
CLAIM = "holds on all 10 pairs"
MOJIBAKE = "\u00e2\u20ac\u201d"

NOTE = (
    "\r\n\r\n--- CF-20 closed 07/09/2026: the final count on the evidence above ---\r\n"
    "The EVIDENCE paragraph earlier in this task says matching suburb and complementary "
    "phone formats - landline on one record, mobile on the other - are consistent with "
    "two import sources for the same customer, and that the pattern holds on all 10 "
    "pairs. It did hold on all 10. It predicted the right answer on 3.\r\n"
    "FINAL RESULT, all 10 pairs answered by 05/09/2026 - 3 same household (Kowalski, "
    "Bennett, Young), 7 separate households (Anderson, Clark, Fitzgerald, Murphy, "
    "Patel, Singh, Tran). This pair: {verdict}.\r\n"
    "The paragraph is left standing rather than edited, so that what was believed on "
    "25/08 and what the calls established can be read against each other. The finding "
    "is that a signal present on every member of a set cannot discriminate between "
    "them - which is the substitution ticket-2.1-data-quality-audit.md sections 3 and 4 "
    "already record as the mistake, arriving a third time. It was right to hold these "
    "pairs rather than merge on it: had they been merged on name similarity plus the "
    "phone pattern, 7 of 10 would have been wrong.")

VERDICT = {
    True:  "SAME household - confirmed by the customer, merge candidate, survivorship "
           "with Marcus",
    False: "SEPARATE households - two customers, do not merge",
}


def apex_escape(s):
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "\\r")


def house_of(subject):
    m = re.search(r"same household as (.+?) Residence", subject)
    if not m:
        return None
    return m.group(1).replace(" J.", "").split()[-1]


q = ("SELECT Id, Subject, Description FROM Task "
     "WHERE Subject LIKE 'HOLD - confirm same household%'")
# NB: no shell=True. On Windows that re-parses the arg list and breaks the
# quoting inside the SOQL, which silently returned the wrong descriptions.
exe = "sf.cmd" if sys.platform == "win32" else "sf"
raw = subprocess.run([exe, "data", "query", "-o", ORG, "-q", q, "--json"],
                     capture_output=True, text=True, check=True).stdout
recs = json.loads(raw)["result"]["records"]

problems, blocks, done = [], [], 0

if len(recs) != 20:
    problems.append("expected 20 CF-20 tasks, found %d" % len(recs))

for r in sorted(recs, key=lambda x: x["Subject"]):
    d = r["Description"] or ""
    house = house_of(r["Subject"])

    if house is None:
        problems.append("%s: cannot parse household from subject" % r["Id"])
        continue
    if house not in SAME and house not in SEPARATE:
        problems.append("%s: unrecognised household %r" % (house, house))
        continue
    if MARKER in d:
        problems.append("%s: closing note already present - rerun would duplicate it" % house)
        continue
    if CLAIM not in d:
        problems.append("%s: the claim this note corrects is not in the task text" % house)
        continue
    if "--- Answered" not in d:
        problems.append("%s: task carries no answer section - CF-20 is not closed on it" % house)
        continue

    # Derive the verdict from the task's own answer, never from the table above.
    tail = d.split("--- Answered")[-1]
    is_same = "NOT the same household" not in tail
    if is_same != (house in SAME):
        problems.append("%s: org answer says %s, script expected %s"
                        % (house, "SAME" if is_same else "SEPARATE",
                           "SAME" if house in SAME else "SEPARATE"))
        continue

    d2 = d.replace(MOJIBAKE, "-") + NOTE.format(verdict=VERDICT[is_same])
    try:
        d2.encode("ascii")
    except UnicodeEncodeError as e:
        problems.append("%s: non-ASCII survives at position %d" % (house, e.start))
        continue

    blocks.append(("// %s (%s)" % (house, "same" if is_same else "separate"),
                   "ups.add(new Task(Id='%s', Description='%s'));" % (r["Id"], apex_escape(d2))))
    done += 1

if problems:
    print("REFUSING TO WRITE - problems:", file=sys.stderr)
    for p in problems:
        print("  " + p, file=sys.stderr)
    sys.exit(1)

if done != 20:
    print("REFUSING TO WRITE - built %d updates, expected 20" % done, file=sys.stderr)
    sys.exit(1)

# Anonymous Apex caps the script body, and twenty full task descriptions is well
# over it. Split into fixed batches of four rather than one file: each is rerunnable
# on its own, and a partial failure names which four to redo.
BATCH = 4
written = []
for i in range(0, len(blocks), BATCH):
    chunk = blocks[i:i + BATCH]
    body = ["List<Task> ups = new List<Task>();", ""]
    for comment, stmt in chunk:
        body += [comment, stmt, ""]
    body += ["update ups;",
             "System.debug('CF20>> batch %d updated: ' + ups.size());" % (i // BATCH + 1)]
    path = OUT.with_name("%s-%02d.apex" % (OUT.stem, i // BATCH + 1))
    path.write_text("\n".join(body), encoding="utf-8")
    written.append((path.name, len(chunk)))

for name, n in written:
    print("wrote", name, "-", n, "tasks")
print("total:", done, "CF-20 tasks in", len(written), "batches")
