"""Copy the OneDrive screenshot evidence into the repo, filed by capture week.

05/09/2026. The captures live only in OneDrive and reach nothing that reads the
repo. Week 1's did the same and CF-14 declared them lost while they sat there.

Filed by the week the screenshot was TAKEN:
  Sat 29/08          -> evidence/week-02/screenshots/   (Week 2 ran Mon 24/08 - Fri 28/08)
  Mon 31/08 onwards  -> evidence/week-03/screenshots/   (Week 3 opened Mon 31/08)

The source folder is named "week 3" but holds both, which is the misfiling this
corrects rather than copies.

COPIES, does not move: OneDrive is the capture point and the only backup until
this branch is pushed. Delete the originals once it is, not before.

Zero-byte files are NOT copied - filing an empty artifact makes a gap look filled.
They are named in the manifest instead.
"""
import hashlib, pathlib, shutil, datetime, collections

SRC = pathlib.Path(r"C:/Users/Hemayet Hossain/OneDrive/Pictures/Salesforce"
                   r"/SunRise-Solar-Internship/evidence/week 3")
REPO = pathlib.Path(__file__).resolve().parent.parent
BOUNDARY = datetime.date(2026, 8, 31)          # Monday, first day of Week 3

def digest(p):
    return hashlib.md5(p.read_bytes()).hexdigest()

copied = collections.defaultdict(list)
empty, seen = [], {}

for f in sorted(SRC.iterdir()):
    if not f.is_file():
        continue
    taken = datetime.date.fromtimestamp(f.stat().st_mtime)
    if f.stat().st_size == 0:
        empty.append((f.name, taken))
        continue
    week = "week-03" if taken >= BOUNDARY else "week-02"
    dest_dir = REPO / "evidence" / week / "screenshots"
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / f.name
    if not dest.exists() or digest(dest) != digest(f):
        shutil.copy2(f, dest)
    d = digest(f)
    seen.setdefault(d, []).append(f.name)
    copied[week].append((f.name, taken, f.stat().st_size, d))

dupes = {d: n for d, n in seen.items() if len(n) > 1}

for week, rows in sorted(copied.items()):
    man = REPO / "evidence" / week / "screenshots" / "MANIFEST.md"
    by_date = collections.Counter(r[1] for r in rows)
    total_mb = sum(r[2] for r in rows) / 1048576
    lines = [
        "# Screenshot evidence - %s" % week,
        "",
        "**Copied from OneDrive 05/09/2026 by `scripts/file-screenshots.py`.**",
        "Source: `OneDrive/Pictures/Salesforce/SunRise-Solar-Internship/evidence/week 3/`",
        "",
        "Filed by the date the screenshot was taken, not by the folder it was found in.",
        "The source folder is named `week 3` and holds both Week 2 and Week 3 captures;",
        "Week 3 opened **Monday 31/08/2026**, so 29/08 belongs to Week 2.",
        "",
        "**%d files, %.1f MB.**" % (len(rows), total_mb),
        "",
        "| Date taken | Files |",
        "|---|---|",
    ] + ["| %s | %d |" % (d.strftime("%d/%m/%Y"), n) for d, n in sorted(by_date.items())] + [
        "",
        "## Files",
        "",
        "| File | Taken | Bytes |",
        "|---|---|---|",
    ] + ["| `%s` | %s | %s |" % (n, t.strftime("%d/%m/%Y"), f"{s:,}")
         for n, t, s, _ in rows]

    if empty and week == "week-03":
        lines += [
            "",
            "## Not copied - zero bytes at source",
            "",
            "These exist in OneDrive with plausible names and timestamps and contain",
            "**nothing**. They are not copied, because filing an empty artifact makes a gap",
            "look filled. Whatever they were meant to capture was never captured.",
            "",
            "| File | Dated |",
            "|---|---|",
        ] + ["| `%s` | %s |" % (n, t.strftime("%d/%m/%Y")) for n, t in empty]

    if dupes:
        rows_here = {r[0] for r in rows}
        shown = [(d, ns) for d, ns in dupes.items() if rows_here & set(ns)]
        if shown:
            lines += ["", "## Identical files (same MD5)", ""]
            lines += ["- `%s`" % "`, `".join(ns) for _, ns in shown]

    man.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("%s: %d files, %.1f MB -> %s" % (week, len(rows), total_mb, man.parent))

print("zero-byte, not copied: %d" % len(empty))
for n, t in empty:
    print("   ", n)
print("duplicate groups: %d" % len(dupes))
