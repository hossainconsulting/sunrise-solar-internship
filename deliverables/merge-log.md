# Merge log — Ticket 2.1

**Reconstructed from the org**, joining `Account` rows where
`IsDeleted = true AND MasterRecordId != null` (queried with `--all-rows`) to their
surviving records. Regenerated 25/08/2026 after the bucket A and B merges.

> **This is a reconstruction, not a contemporaneous log for the first 7 groups.**
> It recovers what was absorbed into what, and when. It does **not** recover field
> values overwritten on a survivor during a merge — Salesforce keeps no history of
> those. Groups merged on 25/08 onward were logged as they happened, in
> `build-log.md`.

**44 merge groups · 233 records absorbed**

| Survivor | Survivor Id | Absorbed | Merged |
|---|---|---|---|
| Amelia Martin | `001gK00001Luv6WQAR` | 7 | 2026-08-23 |
| Andrew Anderson Residence | `001gK00001Luv3zQAB` | 3 | 2026-08-24 |
| Ava Mancini | `001gK00001Luv6aQAB` | 7 | 2026-08-23 |
| Benjamin Walker Residence | `001gK00001Luv3xQAB` | 7 | 2026-08-23 |
| Charlotte King Residence | `001gK00001Luv4GQAR` | 7 | 2026-08-24 |
| Chloe Robinson | `001gK00001Luv6SQAR` | 7 | 2026-08-24 |
| Daniel Clark Residence | `001gK00001Luv4BQAR` | 3 | 2026-08-24 |
| David Doyle Residence | `001gK00001Luv4HQAR` | 7 | 2026-08-24 |
| Ella Ahmed Residence | `001gK00001Luv4CQAR` | 7 | 2026-08-24 |
| Emma Jones Residence | `001gK00001Luv4KQAR` | 5 | 2026-08-24 |
| Ethan Lee Residence | `001gK00001Luv4rQAB` | 7 | 2026-08-24 |
| Grace Whitfield Residence | `001gK00001Luv4OQAR` | 5 | 2026-08-24 |
| Hannah Smith Residence | `001gK00001Luv4MQAR` | 5 | 2026-08-24 |
| Harper Thompson Residence | `001gK00001Luv4WQAR` | 7 | 2026-08-24 |
| Isabella Hall Residence | `001gK00001Luv4UQAR` | 7 | 2026-08-24 |
| Jack White Residence | `001gK00001Luv4PQAR` | 5 | 2026-08-24 |
| James Nguyen Residence | `001gK00001Luv57QAB` | 7 | 2026-08-24 |
| Jessica Silva Residence | `001gK00001Luv3wQAB` | 7 | 2026-08-24 |
| Joshua Patel Residence | `001gK00001Luv4FQAR` | 3 | 2026-08-24 |
| Layla Osman Residence | `001gK00001Luv4cQAB` | 7 | 2026-08-24 |
| Liam Bennett Residence | `001gK00001Luv47QAB` | 3 | 2026-08-24 |
| Liam J. Bennett Residence | `001gK00001Luv6XQAR` | 3 | 2026-08-24 |
| Lily Kelly Residence | `001gK00001Luv4SQAR` | 5 | 2026-08-24 |
| Lucas Tran Residence | `001gK00001Luv4JQAR` | 2 | 2026-08-24 |
| Matthew Kaur Residence | `001gK00001Luv45QAB` | 7 | 2026-08-24 |
| Mia Taylor Residence | `001gK00001Luv3uQAB` | 7 | 2026-08-24 |
| Michael J. Young Residence | `001gK00001Luv6nQAB` | 2 | 2026-08-24 |
| Michael Young Residence | `001gK00001Luv5fQAB` | 2 | 2026-08-24 |
| Nathan Ryan Residence | `001gK00001Luv4LQAR` | 5 | 2026-08-24 |
| Noah Brown Residence | `001gK00001Luv5JQAR` | 7 | 2026-08-24 |
| Oliver Murphy Residence | `001gK00001Luv3vQAB` | 3 | 2026-08-24 |
| Olivia Campbell Residence | `001gK00001Luv4sQAB` | 7 | 2026-08-24 |
| Robert Chen Residence | `001gK00001Luv49QAB` | 7 | 2026-08-24 |
| Ruby Harris Residence | `001gK00001Luv4wQAB` | 7 | 2026-08-24 |
| Ryan J. Singh Residence | `001gK00001Luv6rQAB` | 2 | 2026-08-24 |
| Ryan Singh Residence | `001gK00001Luv55QAB` | 2 | 2026-08-24 |
| Samuel Fitzgerald Residence | `001gK00001Luv4VQAR` | 3 | 2026-08-24 |
| Sarah Barnes Residence | `001gK00001Luv5iQAB` | 5 | 2026-08-24 |
| Sienna Lewis Residence | `001gK00001Luv4iQAB` | 7 | 2026-08-24 |
| Sophie Wilson Residence | `001gK00001Luv48QAB` | 7 | 2026-08-24 |
| Thomas Hughes Residence | `001gK00001Luv3tQAB` | 7 | 2026-08-24 |
| William J. Kowalski Residence | `001gK00001Luv6TQAR` | 3 | 2026-08-24 |
| William Kowalski Residence | `001gK00001Luv43QAB` | 3 | 2026-08-24 |
| Zoe Foster Residence | `001gK00001Luv40QAB` | 7 | 2026-08-24 |

---

## Amelia Martin

**Survivor Id:** `001gK00001Luv6WQAR`  
**Phone:** (02) 4493 1527  
**City:** Wollongong, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Amelia Martin | (02) 4493 1527 | Wollongong | 2026-08-23 20:46:00 UTC |
| Amelia Martin | (02) 6813 4007 | Wollongong | 2026-08-23 20:46:00 UTC |
| Amelia Martin | (02) 5653 2767 | Wollongong | 2026-08-23 20:44:13 UTC |
| Amelia Martin Residence | (02) 7973 5247 | Wollongong | 2026-08-23 20:46:52 UTC |
| Amelia Martin Residence | (02) 6813 4007 | Wollongong | 2026-08-23 20:46:35 UTC |
| Amelia Martin Residence | (02) 5653 2767 | Wollongong | 2026-08-23 20:46:35 UTC |
| Amelia Martin Residence | (02) 4493 1527 | Wollongong | 2026-08-23 20:44:13 UTC |

## Andrew Anderson Residence

**Survivor Id:** `001gK00001Luv3zQAB`  
**Phone:** (02) 4290 1310  
**City:** Campbelltown, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Andrew Anderson Residence | (02) 7770 5030 | Campbelltown | 2026-08-24 15:30:41 UTC |
| Andrew Anderson Residence | (02) 6610 3790 | Chatswood | 2026-08-24 15:30:41 UTC |
| Andrew Anderson Residence | (02) 5450 2550 | Penrith | 2026-08-24 15:30:41 UTC |

**Note:** absorbed records spanned 3 suburbs (Campbelltown, Chatswood, Penrith) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Ava Mancini

**Survivor Id:** `001gK00001Luv6aQAB`  
**Phone:** (02) 4609 1651  
**City:** Liverpool, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Ava Mancini | (02) 5769 2891 | Hornsby | 2026-08-23 21:32:59 UTC |
| Ava Mancini | (02) 6929 4131 | Hurstville | 2026-08-23 21:32:59 UTC |
| Ava Mancini | (02) 4609 1651 | Liverpool | 2026-08-23 21:31:08 UTC |
| Ava Mancini Residence | (02) 5769 2891 | Hornsby | 2026-08-23 21:34:12 UTC |
| Ava Mancini Residence | (02) 6929 4131 | Hurstville | 2026-08-23 21:34:12 UTC |
| Ava Mancini Residence | (02) 4609 1651 | Liverpool | 2026-08-23 21:31:32 UTC |
| Ava Mancini Residence | (02) 8089 5371 | Liverpool | 2026-08-23 21:31:32 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Benjamin Walker Residence

**Survivor Id:** `001gK00001Luv3xQAB`  
**Phone:** (02) 4232 1248  
**City:** Ryde, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Benjamin Walker Residence | (02) 6552 3728 | Castle Hill | 2026-08-24 15:30:39 UTC |
| Benjamin Walker Residence | 0265523728 | Castle Hill | 2026-08-24 15:30:40 UTC |
| Benjamin Walker Residence | 0253922488 | Parramatta | 2026-08-24 15:30:40 UTC |
| Benjamin Walker Residence | (02) 5392 2488 | Parramatta | 2026-08-24 15:30:39 UTC |
| Benjamin Walker Residence | (02) 7712 4968 | Ryde | 2026-08-23 21:47:18 UTC |
| Benjamin Walker Residence | 0242321248 | Ryde | 2026-08-23 21:45:38 UTC |
| Benjamin Walker Residence | 0242321248 | Ryde | 2026-08-23 21:45:38 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Charlotte King Residence

**Survivor Id:** `001gK00001Luv4GQAR`  
**Phone:** (02) 4783 1837  
**City:** Baulkham Hills, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| CHARLOTTE KING RESIDENCE | — | Bankstown | 2026-08-24 15:30:58 UTC |
| CHARLOTTE KING RESIDENCE | — | Baulkham Hills | 2026-08-24 06:36:24 UTC |
| CHARLOTTE KING RESIDENCE | — | Baulkham Hills | 2026-08-24 06:36:24 UTC |
| CHARLOTTE KING RESIDENCE | — | Blacktown | 2026-08-24 15:30:58 UTC |
| Charlotte King Residence | (02) 7103 4317 | Bankstown | 2026-08-24 15:30:58 UTC |
| Charlotte King Residence | (02) 8263 5557 | Baulkham Hills | 2026-08-24 06:36:01 UTC |
| Charlotte King Residence | (02) 5943 3077 | Blacktown | 2026-08-24 15:30:58 UTC |

**Note:** absorbed records spanned 3 suburbs (Bankstown, Baulkham Hills, Blacktown) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Chloe Robinson

**Survivor Id:** `001gK00001Luv6SQAR`  
**Phone:** (02) 4377 1403  
**City:** Cessnock, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Chloe Robinson | (02) 6697 3883 | Cessnock | 2026-08-24 06:38:20 UTC |
| Chloe Robinson | (02) 5537 2643 | Cessnock | 2026-08-24 06:38:20 UTC |
| Chloe Robinson | (02) 4377 1403 | Cessnock | 2026-08-24 06:38:47 UTC |
| Chloe Robinson Residence | (02) 5537 2643 | Cessnock | 2026-08-24 06:39:08 UTC |
| Chloe Robinson Residence | (02) 4377 1403 | Cessnock | 2026-08-24 06:38:47 UTC |
| Chloe Robinson Residence | (02) 6697 3883 | Cessnock | 2026-08-24 06:39:08 UTC |
| Chloe Robinson Residence | (02) 7857 5123 | Cessnock | 2026-08-24 06:39:22 UTC |

## Daniel Clark Residence

**Survivor Id:** `001gK00001Luv4BQAR`  
**Phone:** (02) 4638 1682  
**City:** Campbelltown, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Daniel Clark Residence | (02) 8118 5402 | Campbelltown | 2026-08-24 06:41:21 UTC |
| Daniel Clark Residence | (02) 6958 4162 | Chatswood | 2026-08-24 15:30:50 UTC |
| Daniel Clark Residence | (02) 5798 2922 | Penrith | 2026-08-24 15:30:50 UTC |

**Note:** absorbed records spanned 3 suburbs (Campbelltown, Chatswood, Penrith) — the surviving address was chosen over 2 alternative(s). Bucket B.

## David Doyle Residence

**Survivor Id:** `001gK00001Luv4HQAR`  
**Phone:** (02) 4812 1868  
**City:** Castle Hill, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| David Doyle Residence | 0248121868 | Castle Hill | 2026-08-24 06:46:33 UTC |
| David Doyle Residence | (02) 8292 5588 | Castle Hill | 2026-08-24 06:45:47 UTC |
| David Doyle Residence | 0248121868 | Castle Hill | 2026-08-24 06:45:47 UTC |
| David Doyle Residence | (02) 7132 4348 | Parramatta | 2026-08-24 06:47:27 UTC |
| David Doyle Residence | 0271324348 | Parramatta | 2026-08-24 06:47:27 UTC |
| David Doyle Residence | 0259723108 | Ryde | 2026-08-24 15:30:58 UTC |
| David Doyle Residence | (02) 5972 3108 | Ryde | 2026-08-24 15:30:58 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Ella Ahmed Residence

**Survivor Id:** `001gK00001Luv4CQAR`  
**Phone:** (02) 4667 1713  
**City:** Bankstown, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| ELLA AHMED RESIDENCE | — | Bankstown | 2026-08-24 15:30:51 UTC |
| ELLA AHMED RESIDENCE | — | Bankstown | 2026-08-24 15:30:50 UTC |
| ELLA AHMED RESIDENCE | — | Baulkham Hills | 2026-08-24 15:30:51 UTC |
| ELLA AHMED RESIDENCE | — | Blacktown | 2026-08-24 15:30:51 UTC |
| Ella Ahmed Residence | (02) 8147 5433 | Bankstown | 2026-08-24 15:30:50 UTC |
| Ella Ahmed Residence | (02) 5827 2953 | Baulkham Hills | 2026-08-24 15:30:50 UTC |
| Ella Ahmed Residence | (02) 6987 4193 | Blacktown | 2026-08-24 15:30:50 UTC |

**Note:** absorbed records spanned 3 suburbs (Bankstown, Baulkham Hills, Blacktown) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Emma Jones Residence

**Survivor Id:** `001gK00001Luv4KQAR`  
**Phone:** (02) 4899 1961  
**City:** Charlestown, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| EMMA JONES RESIDENCE | — | Charlestown | 2026-08-24 15:31:01 UTC |
| EMMA JONES RESIDENCE | — | Charlestown | 2026-08-24 15:31:02 UTC |
| EMMA JONES RESIDENCE | — | Charlestown | 2026-08-24 15:31:01 UTC |
| Emma Jones Residence | (02) 6059 3201 | Charlestown | 2026-08-24 15:31:01 UTC |
| Emma Jones Residence | (02) 7219 4441 | Charlestown | 2026-08-24 15:31:01 UTC |

## Ethan Lee Residence

**Survivor Id:** `001gK00001Luv4rQAB`  
**Phone:** (02) 5856 2984  
**City:** Castle Hill, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Ethan Lee Residence | 0258562984 | Castle Hill | 2026-08-24 15:30:52 UTC |
| Ethan Lee Residence | (02) 4696 1744 | Parramatta | 2026-08-24 15:30:51 UTC |
| Ethan Lee Residence | (02) 8176 5464 | Parramatta | 2026-08-24 15:30:51 UTC |
| Ethan Lee Residence | 0246961744 | Parramatta | 2026-08-24 15:30:52 UTC |
| Ethan Lee Residence | 0246961744 | Parramatta | 2026-08-24 15:30:51 UTC |
| Ethan Lee Residence | (02) 7016 4224 | Ryde | 2026-08-24 15:30:51 UTC |
| Ethan Lee Residence | 0270164224 | Ryde | 2026-08-24 15:30:52 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Grace Whitfield Residence

**Survivor Id:** `001gK00001Luv4OQAR`  
**Phone:** (02) 5015 2085  
**City:** Warners Bay, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| GRACE WHITFIELD RESIDENCE | — | Warners Bay | 2026-08-24 15:31:05 UTC |
| GRACE WHITFIELD RESIDENCE | — | Warners Bay | 2026-08-24 15:31:05 UTC |
| GRACE WHITFIELD RESIDENCE | — | Warners Bay | 2026-08-24 15:31:05 UTC |
| Grace Whitfield Residence | (02) 7335 4565 | Warners Bay | 2026-08-24 15:31:04 UTC |
| Grace Whitfield Residence | (02) 6175 3325 | Warners Bay | 2026-08-24 15:31:04 UTC |

## Hannah Smith Residence

**Survivor Id:** `001gK00001Luv4MQAR`  
**Phone:** (02) 4957 2023  
**City:** Singleton, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Hannah Smith | (02) 7277 4503 | Singleton | 2026-08-24 15:31:04 UTC |
| Hannah Smith | (02) 4957 2023 | Singleton | 2026-08-24 15:31:03 UTC |
| Hannah Smith | (02) 6117 3263 | Singleton | 2026-08-24 15:31:03 UTC |
| Hannah Smith Residence | (02) 6117 3263 | Singleton | 2026-08-24 15:31:03 UTC |
| Hannah Smith Residence | (02) 7277 4503 | Singleton | 2026-08-24 15:31:03 UTC |

## Harper Thompson Residence

**Survivor Id:** `001gK00001Luv4WQAR`  
**Phone:** (02) 5247 2333  
**City:** Blacktown, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| HARPER THOMPSON RESIDENCE | — | Bankstown | 2026-08-24 15:31:13 UTC |
| HARPER THOMPSON RESIDENCE | — | Baulkham Hills | 2026-08-24 15:31:14 UTC |
| HARPER THOMPSON RESIDENCE | — | Baulkham Hills | 2026-08-24 15:31:13 UTC |
| HARPER THOMPSON RESIDENCE | — | Blacktown | 2026-08-24 15:31:13 UTC |
| Harper Thompson Residence | (02) 6407 3573 | Bankstown | 2026-08-24 15:31:13 UTC |
| Harper Thompson Residence | (02) 7567 4813 | Baulkham Hills | 2026-08-24 15:31:13 UTC |
| Harper Thompson Residence | (02) 4087 1093 | Baulkham Hills | 2026-08-24 15:31:13 UTC |

**Note:** absorbed records spanned 3 suburbs (Bankstown, Baulkham Hills, Blacktown) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Isabella Hall Residence

**Survivor Id:** `001gK00001Luv4UQAR`  
**Phone:** (02) 5189 2271  
**City:** Hurstville, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Isabella Hall | (02) 4029 1031 | Hornsby | 2026-08-24 15:31:10 UTC |
| Isabella Hall | (02) 4029 1031 | Hornsby | 2026-08-24 15:31:11 UTC |
| Isabella Hall | (02) 5189 2271 | Hurstville | 2026-08-24 15:31:11 UTC |
| Isabella Hall | (02) 6349 3511 | Liverpool | 2026-08-24 15:31:11 UTC |
| Isabella Hall Residence | (02) 7509 4751 | Hornsby | 2026-08-24 15:31:10 UTC |
| Isabella Hall Residence | (02) 4029 1031 | Hornsby | 2026-08-24 15:31:10 UTC |
| Isabella Hall Residence | (02) 6349 3511 | Liverpool | 2026-08-24 15:31:10 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Jack White Residence

**Survivor Id:** `001gK00001Luv4PQAR`  
**Phone:** (02) 5044 2116  
**City:** Wollongong, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Jack White Residence | (02) 7364 4596 | Wollongong | 2026-08-24 15:31:05 UTC |
| Jack White Residence | (02) 6204 3356 | Wollongong | 2026-08-24 15:31:05 UTC |
| Jack White Residence | 0250442116 | Wollongong | 2026-08-24 15:31:06 UTC |
| Jack White Residence | 0262043356 | Wollongong | 2026-08-24 15:31:06 UTC |
| Jack White Residence | 0273644596 | Wollongong | 2026-08-24 15:31:06 UTC |

## James Nguyen Residence

**Survivor Id:** `001gK00001Luv57QAB`  
**Phone:** (02) 6320 3480  
**City:** Ryde, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| James Nguyen Residence | (02) 5160 2240 | Castle Hill | 2026-08-24 15:31:09 UTC |
| James Nguyen Residence | 0251602240 | Castle Hill | 2026-08-24 15:31:09 UTC |
| James Nguyen Residence | 0240001000 | Parramatta | 2026-08-24 15:31:09 UTC |
| James Nguyen Residence | 0240001000 | Parramatta | 2026-08-24 15:31:10 UTC |
| James Nguyen Residence | (02) 7480 4720 | Parramatta | 2026-08-24 15:31:09 UTC |
| James Nguyen Residence | (02) 4000 1000 | Parramatta | 2026-08-24 15:31:09 UTC |
| James Nguyen Residence | 0263203480 | Ryde | 2026-08-24 15:31:09 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Jessica Silva Residence

**Survivor Id:** `001gK00001Luv3wQAB`  
**Phone:** (02) 4203 1217  
**City:** Blacktown, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| JESSICA SILVA RESIDENCE | — | Bankstown | 2026-08-24 15:30:39 UTC |
| JESSICA SILVA RESIDENCE | — | Baulkham Hills | 2026-08-24 15:30:39 UTC |
| JESSICA SILVA RESIDENCE | — | Blacktown | 2026-08-24 15:30:39 UTC |
| JESSICA SILVA RESIDENCE | — | Blacktown | 2026-08-24 15:30:38 UTC |
| Jessica Silva Residence | (02) 5363 2457 | Bankstown | 2026-08-24 15:30:38 UTC |
| Jessica Silva Residence | (02) 6523 3697 | Baulkham Hills | 2026-08-24 15:30:38 UTC |
| Jessica Silva Residence | (02) 7683 4937 | Blacktown | 2026-08-24 15:30:38 UTC |

**Note:** absorbed records spanned 3 suburbs (Bankstown, Baulkham Hills, Blacktown) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Joshua Patel Residence

**Survivor Id:** `001gK00001Luv4FQAR`  
**Phone:** (02) 4754 1806  
**City:** Penrith, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Joshua Patel Residence | (02) 7074 4286 | Campbelltown | 2026-08-24 15:30:56 UTC |
| Joshua Patel Residence | (02) 5914 3046 | Chatswood | 2026-08-24 15:30:56 UTC |
| Joshua Patel Residence | (02) 8234 5526 | Penrith | 2026-08-24 15:30:57 UTC |

**Note:** absorbed records spanned 3 suburbs (Campbelltown, Chatswood, Penrith) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Layla Osman Residence

**Survivor Id:** `001gK00001Luv4cQAB`  
**Phone:** (02) 5421 2519  
**City:** Hornsby, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Layla Osman | (02) 5421 2519 | Hornsby | 2026-08-24 15:30:40 UTC |
| Layla Osman | (02) 6581 3759 | Hurstville | 2026-08-24 15:30:40 UTC |
| Layla Osman | (02) 4261 1279 | Liverpool | 2026-08-24 15:30:41 UTC |
| Layla Osman | (02) 4261 1279 | Liverpool | 2026-08-24 15:30:40 UTC |
| Layla Osman Residence | (02) 6581 3759 | Hurstville | 2026-08-24 15:30:40 UTC |
| Layla Osman Residence | (02) 4261 1279 | Liverpool | 2026-08-24 15:30:40 UTC |
| Layla Osman Residence | (02) 7741 4999 | Liverpool | 2026-08-24 15:30:40 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Liam Bennett Residence

**Survivor Id:** `001gK00001Luv47QAB`  
**Phone:** (02) 4522 1558  
**City:** Wollongong, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Liam Bennett Residence | (02) 5682 2798 | Wollongong | 2026-08-24 15:30:46 UTC |
| Liam Bennett Residence | (02) 8002 5278 | Wollongong | 2026-08-24 15:30:47 UTC |
| Liam Bennett Residence | (02) 6842 4038 | Wollongong | 2026-08-24 15:30:46 UTC |

## Liam J. Bennett Residence

**Survivor Id:** `001gK00001Luv6XQAR`  
**Phone:** 0410142542  
**City:** Wollongong, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Liam J. Bennett Residence | 0410459302 | Wollongong | 2026-08-24 15:31:15 UTC |
| Liam J. Bennett Residence | 0411092822 | Wollongong | 2026-08-24 15:31:16 UTC |
| Liam J. Bennett Residence | 0410776062 | Wollongong | 2026-08-24 15:31:15 UTC |

## Lily Kelly Residence

**Survivor Id:** `001gK00001Luv4SQAR`  
**Phone:** (02) 5131 2209  
**City:** Wollongong, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| LILY KELLY RESIDENCE | — | Wollongong | 2026-08-24 15:31:08 UTC |
| LILY KELLY RESIDENCE | — | Wollongong | 2026-08-24 15:31:08 UTC |
| LILY KELLY RESIDENCE | — | Wollongong | 2026-08-24 15:31:08 UTC |
| Lily Kelly Residence | (02) 7451 4689 | Wollongong | 2026-08-24 15:31:08 UTC |
| Lily Kelly Residence | (02) 6291 3449 | Wollongong | 2026-08-24 15:31:08 UTC |

## Lucas Tran Residence

**Survivor Id:** `001gK00001Luv4JQAR`  
**Phone:** (02) 4870 1930  
**City:** Chatswood, New South Wales

**2 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Lucas Tran Residence | (02) 6030 3170 | Campbelltown | 2026-08-24 15:31:01 UTC |
| Lucas Tran Residence | (02) 7190 4410 | Penrith | 2026-08-24 15:31:01 UTC |

**Note:** absorbed records spanned 2 suburbs (Campbelltown, Penrith) — the surviving address was chosen over 1 alternative(s). Bucket B.

## Matthew Kaur Residence

**Survivor Id:** `001gK00001Luv45QAB`  
**Phone:** (02) 4464 1496  
**City:** Wollongong, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Matthew Kaur Residence | (02) 6784 3976 | Wollongong | 2026-08-24 15:30:45 UTC |
| Matthew Kaur Residence | 0244641496 | Wollongong | 2026-08-24 15:30:46 UTC |
| Matthew Kaur Residence | 0267843976 | Wollongong | 2026-08-24 15:30:46 UTC |
| Matthew Kaur Residence | (02) 7944 5216 | Wollongong | 2026-08-24 15:30:46 UTC |
| Matthew Kaur Residence | (02) 5624 2736 | Wollongong | 2026-08-24 15:30:45 UTC |
| Matthew Kaur Residence | 0244641496 | Wollongong | 2026-08-24 15:30:46 UTC |
| Matthew Kaur Residence | 0256242736 | Wollongong | 2026-08-24 15:30:46 UTC |

## Mia Taylor Residence

**Survivor Id:** `001gK00001Luv3uQAB`  
**Phone:** (02) 4145 1155  
**City:** Hurstville, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Mia Taylor | (02) 6465 3635 | Hornsby | 2026-08-24 15:30:37 UTC |
| Mia Taylor | (02) 4145 1155 | Hurstville | 2026-08-24 15:30:37 UTC |
| Mia Taylor | (02) 4145 1155 | Hurstville | 2026-08-24 15:30:37 UTC |
| Mia Taylor | (02) 5305 2395 | Liverpool | 2026-08-24 15:30:37 UTC |
| Mia Taylor Residence | (02) 6465 3635 | Hornsby | 2026-08-24 15:30:37 UTC |
| Mia Taylor Residence | (02) 7625 4875 | Hurstville | 2026-08-24 15:30:37 UTC |
| Mia Taylor Residence | (02) 5305 2395 | Liverpool | 2026-08-24 15:30:37 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Michael J. Young Residence

**Survivor Id:** `001gK00001Luv6nQAB`  
**Phone:** 0410269246  
**City:** Belmont, New South Wales

**2 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Michael J. Young Residence | 0410586006 | Belmont | 2026-08-24 15:31:16 UTC |
| Michael J. Young Residence | 0410902766 | Belmont | 2026-08-24 15:31:16 UTC |

## Michael Young Residence

**Survivor Id:** `001gK00001Luv5fQAB`  
**Phone:** (02) 7306 4534  
**City:** Belmont, New South Wales

**2 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Michael Young Residence | (02) 4986 2054 | Belmont | 2026-08-24 15:31:04 UTC |
| Michael Young Residence | (02) 6146 3294 | Belmont | 2026-08-24 15:31:04 UTC |

## Nathan Ryan Residence

**Survivor Id:** `001gK00001Luv4LQAR`  
**Phone:** (02) 4928 1992  
**City:** Newcastle, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Nathan Ryan Residence | (02) 6088 3232 | Newcastle | 2026-08-24 15:31:02 UTC |
| Nathan Ryan Residence | 0260883232 | Newcastle | 2026-08-24 15:31:02 UTC |
| Nathan Ryan Residence | (02) 7248 4472 | Newcastle | 2026-08-24 15:31:02 UTC |
| Nathan Ryan Residence | 0272484472 | Newcastle | 2026-08-24 15:31:03 UTC |
| Nathan Ryan Residence | 0249281992 | Newcastle | 2026-08-24 15:31:02 UTC |

## Noah Brown Residence

**Survivor Id:** `001gK00001Luv5JQAR`  
**Phone:** (02) 6668 3852  
**City:** Raymond Terrace, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Noah Brown Residence | 0243481372 | Raymond Terrace | 2026-08-24 15:30:43 UTC |
| Noah Brown Residence | (02) 4348 1372 | Raymond Terrace | 2026-08-24 15:30:42 UTC |
| Noah Brown Residence | 0243481372 | Raymond Terrace | 2026-08-24 15:30:43 UTC |
| Noah Brown Residence | (02) 5508 2612 | Raymond Terrace | 2026-08-24 15:30:42 UTC |
| Noah Brown Residence | (02) 7828 5092 | Raymond Terrace | 2026-08-24 15:30:43 UTC |
| Noah Brown Residence | 0266683852 | Raymond Terrace | 2026-08-24 15:30:43 UTC |
| Noah Brown Residence | 0255082612 | Raymond Terrace | 2026-08-24 15:30:43 UTC |

## Oliver Murphy Residence

**Survivor Id:** `001gK00001Luv3vQAB`  
**Phone:** (02) 4174 1186  
**City:** Chatswood, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Oliver Murphy Residence | (02) 5334 2426 | Campbelltown | 2026-08-24 15:30:38 UTC |
| Oliver Murphy Residence | (02) 7654 4906 | Chatswood | 2026-08-24 15:30:38 UTC |
| Oliver Murphy Residence | (02) 6494 3666 | Penrith | 2026-08-24 15:30:38 UTC |

**Note:** absorbed records spanned 3 suburbs (Campbelltown, Chatswood, Penrith) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Olivia Campbell Residence

**Survivor Id:** `001gK00001Luv4sQAB`  
**Phone:** (02) 5885 3015  
**City:** Hurstville, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Olivia Campbell | (02) 4725 1775 | Hornsby | 2026-08-24 15:31:14 UTC |
| Olivia Campbell | (02) 4725 1775 | Hornsby | 2026-08-24 15:31:14 UTC |
| Olivia Campbell | (02) 5885 3015 | Hurstville | 2026-08-24 15:31:14 UTC |
| Olivia Campbell | (02) 7045 4255 | Liverpool | 2026-08-24 15:31:14 UTC |
| Olivia Campbell Residence | (02) 8205 5495 | Hornsby | 2026-08-24 15:31:14 UTC |
| Olivia Campbell Residence | (02) 4725 1775 | Hornsby | 2026-08-24 15:30:52 UTC |
| Olivia Campbell Residence | (02) 7045 4255 | Liverpool | 2026-08-24 15:30:52 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Robert Chen Residence

**Survivor Id:** `001gK00001Luv49QAB`  
**Phone:** (02) 4580 1620  
**City:** Ryde, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Robert Chen Residence | 0269004100 | Castle Hill | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | (02) 6900 4100 | Castle Hill | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | (02) 5740 2860 | Parramatta | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | 0257402860 | Parramatta | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | 0245801620 | Ryde | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | (02) 8060 5340 | Ryde | 2026-08-24 15:30:49 UTC |
| Robert Chen Residence | 0245801620 | Ryde | 2026-08-24 15:30:49 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Ruby Harris Residence

**Survivor Id:** `001gK00001Luv4wQAB`  
**Phone:** (02) 6001 3139  
**City:** Liverpool, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Ruby Harris | (02) 7161 4379 | Hornsby | 2026-08-24 15:31:00 UTC |
| Ruby Harris | (02) 4841 1899 | Hurstville | 2026-08-24 15:30:59 UTC |
| Ruby Harris | (02) 4841 1899 | Hurstville | 2026-08-24 15:31:00 UTC |
| Ruby Harris | (02) 6001 3139 | Liverpool | 2026-08-24 15:31:00 UTC |
| Ruby Harris Residence | (02) 7161 4379 | Hornsby | 2026-08-24 15:30:59 UTC |
| Ruby Harris Residence | (02) 8321 5619 | Hurstville | 2026-08-24 15:30:59 UTC |
| Ruby Harris Residence | (02) 4841 1899 | Hurstville | 2026-08-24 15:30:59 UTC |

**Note:** absorbed records spanned 3 suburbs (Hornsby, Hurstville, Liverpool) — the surviving address was chosen over 2 alternative(s). Bucket B.

## Ryan J. Singh Residence

**Survivor Id:** `001gK00001Luv6rQAB`  
**Phone:** 0410300922  
**City:** Wollongong, New South Wales

**2 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Ryan J. Singh Residence | 0410617682 | Wollongong | 2026-08-24 15:31:16 UTC |
| Ryan J. Singh Residence | 0410934442 | Wollongong | 2026-08-24 15:31:16 UTC |

## Ryan Singh Residence

**Survivor Id:** `001gK00001Luv55QAB`  
**Phone:** (02) 6262 3418  
**City:** Wollongong, New South Wales

**2 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Ryan Singh Residence | (02) 7422 4658 | Wollongong | 2026-08-24 15:31:07 UTC |
| Ryan Singh Residence | (02) 5102 2178 | Wollongong | 2026-08-24 15:31:07 UTC |

## Samuel Fitzgerald Residence

**Survivor Id:** `001gK00001Luv4VQAR`  
**Phone:** (02) 5218 2302  
**City:** Chatswood, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Samuel Fitzgerald Residence | (02) 6378 3542 | Campbelltown | 2026-08-24 15:31:11 UTC |
| Samuel Fitzgerald Residence | (02) 7538 4782 | Penrith | 2026-08-24 15:31:11 UTC |
| Samuel Fitzgerald Residence | (02) 4058 1062 | Penrith | 2026-08-24 15:31:12 UTC |

**Note:** absorbed records spanned 2 suburbs (Campbelltown, Penrith) — the surviving address was chosen over 1 alternative(s). Bucket B.

## Sarah Barnes Residence

**Survivor Id:** `001gK00001Luv5iQAB`  
**Phone:** (02) 7393 4627  
**City:** Wollongong, New South Wales

**5 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Sarah Barnes | (02) 5073 2147 | Wollongong | 2026-08-24 15:31:07 UTC |
| Sarah Barnes | (02) 6233 3387 | Wollongong | 2026-08-24 15:31:07 UTC |
| Sarah Barnes | (02) 7393 4627 | Wollongong | 2026-08-24 15:31:07 UTC |
| Sarah Barnes Residence | (02) 5073 2147 | Wollongong | 2026-08-24 15:31:06 UTC |
| Sarah Barnes Residence | (02) 6233 3387 | Wollongong | 2026-08-24 15:31:06 UTC |

## Sienna Lewis Residence

**Survivor Id:** `001gK00001Luv4iQAB`  
**Phone:** (02) 5595 2705  
**City:** Charlestown, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| SIENNA LEWIS RESIDENCE | — | Charlestown | 2026-08-24 15:30:45 UTC |
| SIENNA LEWIS RESIDENCE | — | Charlestown | 2026-08-24 15:30:45 UTC |
| SIENNA LEWIS RESIDENCE | — | Charlestown | 2026-08-24 15:30:45 UTC |
| SIENNA LEWIS RESIDENCE | — | Charlestown | 2026-08-24 15:30:44 UTC |
| Sienna Lewis Residence | (02) 6755 3945 | Charlestown | 2026-08-24 15:30:44 UTC |
| Sienna Lewis Residence | (02) 7915 5185 | Charlestown | 2026-08-24 15:30:44 UTC |
| Sienna Lewis Residence | (02) 4435 1465 | Charlestown | 2026-08-24 15:30:44 UTC |

## Sophie Wilson Residence

**Survivor Id:** `001gK00001Luv48QAB`  
**Phone:** (02) 4551 1589  
**City:** Wollongong, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| SOPHIE WILSON RESIDENCE | — | Wollongong | 2026-08-24 15:30:48 UTC |
| SOPHIE WILSON RESIDENCE | — | Wollongong | 2026-08-24 15:30:48 UTC |
| SOPHIE WILSON RESIDENCE | — | Wollongong | 2026-08-24 15:30:47 UTC |
| SOPHIE WILSON RESIDENCE | — | Wollongong | 2026-08-24 15:30:48 UTC |
| Sophie Wilson Residence | (02) 5711 2829 | Wollongong | 2026-08-24 15:30:47 UTC |
| Sophie Wilson Residence | (02) 6871 4069 | Wollongong | 2026-08-24 15:30:47 UTC |
| Sophie Wilson Residence | (02) 8031 5309 | Wollongong | 2026-08-24 15:30:47 UTC |

## Thomas Hughes Residence

**Survivor Id:** `001gK00001Luv3tQAB`  
**Phone:** (02) 4116 1124  
**City:** Castle Hill, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| Thomas Hughes Residence | (02) 7596 4844 | Castle Hill | 2026-08-24 15:30:36 UTC |
| Thomas Hughes Residence | 0241161124 | Castle Hill | 2026-08-24 15:30:36 UTC |
| Thomas Hughes Residence | 0241161124 | Castle Hill | 2026-08-24 15:30:36 UTC |
| Thomas Hughes Residence | (02) 6436 3604 | Parramatta | 2026-08-24 15:30:35 UTC |
| Thomas Hughes Residence | 0264363604 | Parramatta | 2026-08-24 15:30:36 UTC |
| Thomas Hughes Residence | (02) 5276 2364 | Ryde | 2026-08-24 15:30:35 UTC |
| Thomas Hughes Residence | 0252762364 | Ryde | 2026-08-24 15:30:36 UTC |

**Note:** absorbed records spanned 3 suburbs (Castle Hill, Parramatta, Ryde) — the surviving address was chosen over 2 alternative(s). Bucket B.

## William J. Kowalski Residence

**Survivor Id:** `001gK00001Luv6TQAR`  
**Phone:** 0410110866  
**City:** Maitland, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| William J. Kowalski Residence | 0410427626 | Maitland | 2026-08-24 15:31:15 UTC |
| William J. Kowalski Residence | 0411061146 | Maitland | 2026-08-24 15:31:15 UTC |
| William J. Kowalski Residence | 0410744386 | Maitland | 2026-08-24 15:31:15 UTC |

## William Kowalski Residence

**Survivor Id:** `001gK00001Luv43QAB`  
**Phone:** (02) 4406 1434  
**City:** Maitland, New South Wales

**3 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| William Kowalski Residence | (02) 5566 2674 | Maitland | 2026-08-24 15:30:43 UTC |
| William Kowalski Residence | (02) 6726 3914 | Maitland | 2026-08-24 15:30:43 UTC |
| William Kowalski Residence | (02) 7886 5154 | Maitland | 2026-08-24 15:30:44 UTC |

## Zoe Foster Residence

**Survivor Id:** `001gK00001Luv40QAB`  
**Phone:** (02) 4319 1341  
**City:** Warners Bay, New South Wales

**7 records absorbed:**

| Absorbed record | Former phone | Former city | Merged at |
|---|---|---|---|
| ZOE FOSTER RESIDENCE | — | Warners Bay | 2026-08-24 15:30:42 UTC |
| ZOE FOSTER RESIDENCE | — | Warners Bay | 2026-08-24 15:30:42 UTC |
| ZOE FOSTER RESIDENCE | — | Warners Bay | 2026-08-24 15:30:42 UTC |
| ZOE FOSTER RESIDENCE | — | Warners Bay | 2026-08-24 15:30:42 UTC |
| Zoe Foster Residence | (02) 5479 2581 | Warners Bay | 2026-08-24 15:30:41 UTC |
| Zoe Foster Residence | (02) 6639 3821 | Warners Bay | 2026-08-24 15:30:41 UTC |
| Zoe Foster Residence | (02) 7799 5061 | Warners Bay | 2026-08-24 15:30:42 UTC |

