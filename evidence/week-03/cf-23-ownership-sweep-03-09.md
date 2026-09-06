# CF-23 — ownership sweep, verified

**Org `sunrise` (`00DgK00000WyBZGUA3`) · Run 03/09/2026 · Read-only, nothing written**
**Script: [`scripts/cf-23-verify-sweep.apex`](../../scripts/cf-23-verify-sweep.apex)**

CF-23 closed on 02/09 asserting *"all 187 ownable objects sweep to zero"*. **No output was
captured**, so the claim rested on a commit message. This is the artifact.

## Result: PASS

| | |
|---|---|
| Ownable objects found by describe | **187** — matches the claim exactly |
| Objects successfully counted | **185** |
| Objects that cannot be counted this way | **2** |
| **Records owned by the five users** | **0** |

**Users swept (all 5 resolved):** OrgFarm EPIC, Jack Nguyen, Mia Kelly, Alan Brooks,
Lisa Fernandez.

| Chunk | Object range | Scanned | Skipped | Owned | Verdict |
|---|---|---|---|---|---|
| 0 | 0–79 | 80 | 0 | 0 | PASS |
| 1 | 80–159 | 78 | 2 | 0 | PASS |
| 2 | 160–186 | 27 | 0 | 0 | PASS |
| **Total** | **0–186** | **185** | **2** | **0** | **PASS** |

## The two that could not be counted

`ListViewEvent` and `ReportEvent` — both returned *"field 'OwnerId' can not be filtered in
a query call"*. They are Event Monitoring objects: an `OwnerId` exists on the schema but
the platform does not allow filtering on it. **Neither is a record-ownership object in the
custody sense** — nothing is transferred to or stranded on a user through them.

**Stated rather than rounded off.** The honest claim is **185 of 187 confirmed zero, 2
unqueryable by this method** — not "187 of 187". CF-23's history is a count that was wrong
twice, and the fix for that is not a third confident number.

## What running it found about the original sweep

**The first attempt died on `System.LimitException: Too many SOQL queries: 101`.**

`Database.countQuery` is a SOQL query and anonymous Apex allows 100 per execution. **A
187-object sweep cannot run in one execution.** This script therefore chunks — 80 objects
per run, three runs.

That matters for reading the 02/09 record. [`cf-23-epic-remainder-transfer.apex`](../../scripts/cf-23-epic-remainder-transfer.apex)
sweeps **one** object per execution (`TARGET`) and re-counts only that one. **Neither
script as committed on 02/09 could have produced the "all 187 sweep to zero" line in that
commit message.** The transfer itself is verified good — the objects are clean today — but
the sweep behind the sentence was either done another way and not recorded, or not done.

> **The claim was true. The evidence for it did not exist.** That is a narrower failure
> than CF-02's, and the same family: a record saying the work was done, standing in for the
> record of the work.

## Reproducing

```
sf apex run -o sunrise -f scripts/cf-23-verify-sweep.apex   # CHUNK = 0
# edit CHUNK to 1, run again
# edit CHUNK to 2, run again
```

Grep the output for `CF23>>`. A non-zero `owned` count prints the object and the number on
a `CF23>> owned,<object>,<n>` line and flips the verdict to FAIL.
