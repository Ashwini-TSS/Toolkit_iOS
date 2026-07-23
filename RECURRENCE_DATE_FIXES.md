# Recurrence Date Fixes — Quick Reference

**File touched:** `Pareto Systems/Leftmenu/Services/CreateRecurrencePattern.swift`
(plus a temporary log in `Pareto Systems/Leftmenu/System/TeammembesDetailsVC.swift`)
**Feature:** Create / Edit a recurring appointment (recurrence pattern).
**Symptom:** The number of days created did not match the picked date range — off by ±1
(e.g. picked 27→30 got only 28,29; picked 21→25 got 21–24; picked 26→29 got 27→30),
and it behaved differently on US vs IST devices.

---

## ✅ 0. CURRENT STATUS (read first) — 2026‑07‑18

**Current code = WEB‑mirror fix. Builds clean.** See Bug B in §2 for the full three‑attempt story.

`RecurrenceStart`/`RecurrenceEnd` are now sent in **UTC (literal `Z`)**, both carrying the **START
time‑of‑day** — matching the web platform, which was confirmed creating the same Aug 25→31
recurrence successfully:
```
RecurrenceStart = start date + start time, UTC 'Z'   e.g. 2026-08-25T12:00:00.000Z
RecurrenceEnd   = end   date + start time, UTC 'Z'   e.g. 2026-08-31T12:00:00.000Z
```
This replaced an earlier **Android‑mirror** attempt that sent the range in the `-0400` offset format
with the END time — that hit a server parser bug (noon‑shift + end day reset to `01`, e.g. Aug 31→
Aug 01) and created **NOTHING** while the popup still said "success".

**Still to verify on device:** create Aug 25→31 and Nov 24→30, confirm the `🟣[REC-CREATE] range
(Web-style UTC)` log shows `…Z` values and the server stores the correct end date / all days.

---

## 1. How the server actually behaves (reverse‑engineered from logs)

Two kinds of fields are treated **differently** by the server:

| Field | Server treatment |
|-------|------------------|
| `StartTime` / `EndTime` | **True instant.** Your local time is converted to UTC by the real offset and round‑trips correctly. Works on any timezone. |
| `RecurrenceStart` / `RecurrenceEnd` | The server **discards the time‑of‑day** and re‑anchors the value to **NOON in the org's timezone** (America/Los_Angeles, DST‑aware: `20:00Z` in PST winter, `19:00Z` in PDT summer). |

**Occurrence rule:** a day is created only if its occurrence instant (at the `StartTime`
time‑of‑day) falls inside the **noon‑to‑noon** window. So:

- Appointment **after noon** (e.g. 11 PM) → the **last** day's occurrence lands past the noon
  ceiling → last day **dropped**.
- Appointment **before noon** (e.g. 8:15 AM) → the **first** (and last) day's occurrence lands
  before the noon floor → boundary day(s) **dropped**.
- **US vs IST divergence:** the same 11 PM wall‑clock converts to a different UTC instant
  (US‑Pacific → next day 07:00Z, IST → same day 17:30Z), so it lands on different sides of the
  noon ceiling → different day counts for identical input.

> Strong inference (from iOS logs; not yet confirmed with an Android server log):
> the server applies a classic **"if datetime == midnight 00:00:00, treat as date‑only and
> re‑anchor to noon"** rule. Sending a real (non‑midnight) time avoids that re‑anchoring.

---

## 2. Bugs found & fixed

### Bug A — Year jumps forward for late‑December dates (`YYYY` week‑year)
- **Cause:** date formatters used capital **`YYYY`** (ISO *week‑numbering year*). For a late‑December
  date such as **Dec 29 2027**, that week rolls into week 1 of 2028, so `YYYY` printed **2028**.
  Some formatters also had **no fixed locale**, making it locale‑dependent.
- **Evidence (log):** picked `2027-12-29` → `textField.text set to = 2028-12-29` → request sent
  `RecurrenceEnd = 2028-12-30…` → a ~369‑day runaway recurrence.
- **Fix:** flipped **all 9** `"YYYY-MM-dd"` → `"yyyy-MM-dd"` (calendar year), and added
  `Locale(identifier: "en_US_POSIX")` to the 3 formatters that lacked it (two parse spots +
  the one that sets `textField.text`). Updated the stale warning comment.

### Bug B — Wrong day count / nothing created (recurrence range) — FIXED by mirroring WEB
This one went through **three iterations**. Final fix = mirror the **web platform**.

**Attempt 1 (old): midnight both bounds** — `RecurrenceStart`/`RecurrenceEnd` at `00:00:00` in the
device offset format. The server re‑anchored to **noon**, dropping the first/last occurrence for
before/after‑noon appointments → **±1 day** (27→30 got 28,29; 21→25 got 21–24). Date stayed correct.

**Attempt 2 (Android‑mirror): real time‑of‑day, offset format** — `RecurrenceStart` = start+start
time, `RecurrenceEnd` = end+**end** time, still in `…-0400` offset format. **REGRESSION:** the server
mishandled the offset format on the range fields — it noon‑shifted the start and **reset the end
day to `01`** (Aug 31→Aug 01, Nov 30→Nov 01) → backwards/empty range → **NOTHING created** while the
popup said "success". The Android approach was never confirmed against an Android server log.

**Attempt 3 (FINAL): mirror the WEB platform ✅** — proven by a web inspect doc creating the same
Aug 25→31 recurrence successfully. Web sends:
```
StartTime:       2026-08-25T12:00:00.000Z
RecurrenceStart: 2026-08-25T12:00:00.000Z     (start date + START time, UTC 'Z')
RecurrenceEnd:   2026-08-31T12:00:00.000Z     (end   date + START time, UTC 'Z')  ← Aug 31 correct
```
Two things make web work:
1. **UTC with a literal `Z`** (not `-0400`). The server's `RecurrenceStart`/`RecurrenceEnd` parser
   handles `Z` correctly but corrupts the `+/-HHmm` offset format. (`StartTime`/`EndTime` use a
   different, offset‑tolerant parser — that is why those always worked.)
2. **Both bounds carry the START time‑of‑day**, so each bound equals the exact daily occurrence
   instant → the server includes every day inclusively (no first/last drop, no noon issue).

- **Fix applied:** in both create and edit flows, build `RecurrenceStart` = start date + start time
  and `RecurrenceEnd` = end date + start time, formatted **UTC** with `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`.
  `StartTime`/`EndTime` left untouched.
- **Note:** the earlier Android‑mirror approach was fully reverted/replaced by this.

---

## 3. Exact iOS changes (`CreateRecurrencePattern.swift`)

### 3a. Date‑format bug (Bug A) — whole file
- Every `formatter.dateFormat = "YYYY-MM-dd"` → `"yyyy-MM-dd"` (9 occurrences).
- Added `formatter.locale = Locale(identifier: "en_US_POSIX")` at:
  the start‑date min‑date parse, the picker‑setup parse, and the `textField.text` format
  (the spot that produced `2028-12-29`).

### 3b. Create flow — `createServiceWithRecurrenceID(recID:)`
Replaced the "pin both bounds to `00:00:00`" block with:
```swift
// RecurrenceStart = StartTime (recurrence start date + start time-of-day), same as Android.
lblRecurrenceStartTime = lblStartTime
// RecurrenceEnd = end date + END time-of-day (Android: formatted_end_output_time).
if let recEndDay = recDateFmt.date(from: recEndDateStr),
   let pickedEnd = recTimeFmt.date(from: fieldEndTime.text ?? "") {
    let eTOD = recCal.dateComponents([.hour, .minute], from: pickedEnd)
    var c = recCal.dateComponents([.year, .month, .day], from: recEndDay)
    c.hour = eTOD.hour; c.minute = eTOD.minute; c.second = 0
    if let d = recCal.date(from: c) { lblRecurrenceEndTime = recIsoFmt.string(from: d) }
}
```
Log line: `🟣[REC-CREATE] range (Android-style) -> …`

### 3c. Edit flow — `updateRecurrencePattern()` (existing‑pattern `else` branch)
Replaced the two `setValue(lblRecurrence…Time, forKey:)` calls with bounds built explicitly from
the on‑screen date fields + appointment time‑of‑day (with safe fallbacks):
- `RecurrenceStart` = `filedRecurrenceStart.text` + `fieldStartTime.text`
- `RecurrenceEnd`   = `filedRecurrenceEnd.text` + `fieldEndTime.text`

Log line: `🟣[REC-UPDATE] range (Android-style) -> …`

> Note: the `serviceList != nil` branch only updates a single service's `StartTime`/`EndTime`
> and never sets the recurrence range → intentionally left unchanged.

### 3d. Temporary diagnostic (`TeammembesDetailsVC.swift`, ~line 169)
Added a `🕒[ORG-TZ]` print to capture the exact company `TimeZone` string the server returns
(prints on the Team Member details screen). **Not yet captured** — remove once no longer needed.

---

## 4. Before / after (example: picked 27→30, 8:15 AM–4:15 PM, US‑Pacific)

| Field | Before (broken) | After (Android‑style) |
|-------|-----------------|-----------------------|
| StartTime | `2027-12-27T08:15:00-0800` | `2027-12-27T08:15:00-0800` (unchanged) |
| EndTime | `2027-12-27T16:15:00-0800` | `2027-12-27T16:15:00-0800` (unchanged) |
| RecurrenceStart | `2027-12-27T`**`00:00:00`**`-0800` | `2027-12-27T`**`08:15:00`**`-0800` |
| RecurrenceEnd | `2027-12-30T`**`00:00:00`**`-0800` | `2027-12-30T`**`16:15:00`**`-0800` |
| Days created | 28, 29 (**2**) | expected 27, 28, 29, 30 (**4**) |

---

## 5. Android → iOS parity (what was mirrored vs. intentionally not)

Only the **bug‑causing** Android behaviors were mirrored. A few Android details were **left
different on purpose** because iOS already works and copying them risked a regression.

### Mirrored ✅
| Android behavior | Mirrored in iOS? | Where |
|------------------|------------------|-------|
| Lowercase `yyyy` + fixed English locale (no week‑year bug) | ✅ | all 9 formatters + `en_US_POSIX` |
| `RecurrenceStart` = start date **+ start time‑of‑day** (not midnight) | ✅ | create + edit flows |
| `RecurrenceEnd` = end date **+ end time‑of‑day** (not midnight) | ✅ | create + edit flows |

### NOT mirrored (intentional) ⚠️
| # | Android behavior | iOS (unchanged) | Why left as‑is |
|---|------------------|-----------------|----------------|
| 1 | `EndTime` = **end** date + end time (e.g. `Dec 30 4:15 PM`) | `EndTime` = **start** date + end time (e.g. `Dec 27 4:15 PM`) | iOS `StartTime`/`EndTime` already round‑trip correctly; iOS's version describes a single‑day occurrence more correctly. The recurrence **range** (the broken part) is Android‑style regardless. |
| 2 | `RecurrenceEnd = null` when end date empty | Falls back to an existing value | Edge case (open‑ended recurrence); kept iOS's fallback. |
| 3 | Offset format `ZZZZZ` → `-08:00` (with colon) | `Z` → `-0800` (no colon) | Cosmetic; server accepts both, iOS has always sent `-0800`. |

> If strict parity is ever required, items #1 and #2 are the candidates — but #1 changes
> `StartTime`/`EndTime` behavior that currently works, so test the current fix first.

## 6. Verification checklist
- [ ] Build in Xcode. (The `No such module 'UIKit'` SourceKit warning is an indexing artifact,
      unrelated to these edits.)
- [ ] **Create** a recurrence 27→30 morning time → check `🟣[REC-CREATE]` log → confirm server
      stores `RecurrenceStart` at the real time (not noon) and creates all 4 days.
- [ ] Re‑test **11 PM** Dec 21→25 → should now be 5 days.
- [ ] **Edit** an existing recurrence range → check `🟣[REC-UPDATE]` log and day count.
- [ ] Normal (non‑recurring) appointment → unaffected.
- [ ] Late‑December end date (Dec 29–31) → year stays correct (no 2028 jump).

## 7. Open items / follow‑ups
- Capture the `🕒[ORG-TZ]` value to confirm the org timezone string format (needed only if
  handling **non‑Pacific** orgs precisely; Pacific is confirmed for the current org).
- Confirm one **Android** recurrence create request+response to prove the "midnight → noon"
  server theory outright.
- **Durable fix is server‑side:** stop re‑anchoring `RecurrenceStart`/`RecurrenceEnd` to noon;
  compare the occurrence's **date in org tz** against the range **dates, inclusive**. Raise with
  backend team (attach the request/response logs as evidence).
- Remove the temporary `🕒[ORG-TZ]` log once the timezone question is closed.
