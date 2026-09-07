"""Copy the OneDrive screenshot evidence into the repo, filed by capture week.

05/09/2026. The captures live only in OneDrive and reach nothing that reads the
repo. Week 1's did the same and CF-14 declared them lost while they sat there.

COPIES, does not move: OneDrive is the capture point and the only backup until
the branch is pushed. Delete the originals once it is, not before.

Zero-byte files are NOT copied - filing an empty artifact makes a gap look filled.
They are named in the manifest instead.

--- Generalised 07/09/2026 -------------------------------------------------

Originally hardcoded to the `week 3` source folder with a single 31/08 boundary,
because that folder held both Week 2 and Week 3 captures and the point was to
correct that misfiling rather than copy it.

That boundary is now a table of week start dates, which reproduces the original
behaviour exactly (29/08 still lands in week-02, 31/08 still lands in week-03)
and extends to Week 4 without a second copy of this script. The source folder is
an argument, so a folder named for one week can still hold captures from another
and they will be filed by the date they were TAKEN, not by the folder name.

Usage:  python file-screenshots.py ["<source folder>" ...]
Default: the "week 4" folder.
"""
import hashlib, pathlib, shutil, datetime, collections, sys

ONEDRIVE = pathlib.Path(r"C:/Users/Hemayet Hossain/OneDrive/Pictures/Salesforce"
                        r"/SunRise-Solar-Internship/evidence")
REPO = pathlib.Path(__file__).resolve().parent.parent
TODAY = datetime.date.today()

# Monday of each week of the internship. A capture is filed into the last week
# whose start date is on or before the day it was taken.
WEEK_STARTS = [
    (datetime.date(2026, 8, 17), "week-01"),
    (datetime.date(2026, 8, 24), "week-02"),
    (datetime.date(2026, 8, 31), "week-03"),
    (datetime.date(2026, 9, 7),  "week-04"),
]

SOURCES = [pathlib.Path(a) for a in sys.argv[1:]] or [ONEDRIVE / "week 4"]


def week_of(taken):
    label = WEEK_STARTS[0][1]
    for start, name in WEEK_STARTS:
        if taken >= start:
            label = name
    return label


def digest(p):
    return hashlib.md5(p.read_bytes()).hexdigest()


copied = collections.defaultdict(list)
empty, seen, sources_used = [], {}, []

for src in SOURCES:
    if not src.is_dir():
        sys.exit("no such folder: %s" % src)
    sources_used.append(src)
    for f in sorted(src.iterdir()):
        if not f.is_file():
            continue
        taken = datetime.date.fromtimestamp(f.stat().st_mtime)
        if f.stat().st_size == 0:
            empty.append((f.name, taken))
            continue
        week = week_of(taken)
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
        "**Copied from OneDrive %s by `scripts/file-screenshots.py`.**"
        % TODAY.strftime("%d/%m/%Y"),
        "Source: %s" % ", ".join("`%s`" % s.name for s in sources_used),
        "",
        "Filed by the date the screenshot was taken, not by the folder it was found in.",
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

    if empty:
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
for _, ns in dupes.items():
    print("   ", ", ".join(ns))
