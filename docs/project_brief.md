# Project Brief — Analog Coding Workbook Series

*Last updated: March 2026*

---

## Core Idea

AI coding tools make it easier to generate code, but harder to stay sharp at reasoning about code manually.

This series provides **analog deliberate practice for developers**:

- Writing code by hand
- Tracing execution
- Finding bugs
- Reasoning without running code

The goal is to train one specific skill: **thinking about code without a computer.**

---

## Difficulty Philosophy

All books follow this rule:

> Problems should be solvable by a working developer without studying algorithms or memorizing interview tricks.

**Include:**
- Loops, lists, dictionaries, strings
- Basic recursion
- Binary search
- Scope, mutation, references
- Common bugs and real-world logic

**Exclude (Volume 1):**
- Dynamic programming
- Graph algorithms
- Advanced data structures
- System design
- Competitive programming tricks

Harder material goes in later volumes.

---

## Difficulty Scale


Four levels used across all books, shown as text labels:

| Label | Description |
|---|---|
| Easy | Core syntax and logic, minimal complexity |
| Medium | Everyday dev tasks, built-in methods, real code |
| Hard | Multi-step logic, tricky edge cases |
| Challenge | Harder problems still within the "no algorithms" rule |

No junior/senior labels. Mixed difficulty within each book.

---

## Launch Plan

Start with two books:

- **The Analog Coding Workbook: JavaScript Edition**
- **The Analog Coding Workbook: Python Edition**

Both will be nearly identical in structure, with exercises adapted per language. Release together at launch.

Follow with:
- **The Analog Coding Workbook: Web Development Edition** (after initial launch)

**Target milestone:** ~1,000 copies sold (combined)

If successful: add volumes, improve production, expand the series.

**Possible future books:**
Interview Prep Edition, Volume 2, Find the Bug Edition, 10-Minute Coding Workout, Advanced Edition

---

## Book Structure

Each book ≈ 90–100 pages. Same structure for JS and Python editions.

Total exercises ≈ 75.

---

### Front Matter (~5 pages)

- Title page 🔲 *todo*
- Copyright page 🔲 *todo*
- Dedication 🔲 *todo*
- Table of contents 🔲 *todo* (auto-generated from Typst headings)
- Introduction and philosophy ✅
- Difficulty explanation 🔲 *todo*
- How to use the workbook 🔲 *todo*

Key line in every intro:
> Problems are chosen so that a working developer could reasonably solve them without studying algorithms.

**Note:** Introduction should include a brief mention directing readers to the appendix for Python reference material.

---

### Appendix 🔲 *todo*

Python quick-reference material for readers to use analog-style (no searching required during problems).

Planned content:
- Common list methods (append, pop, insert, remove, sort, etc.)
- Common string methods (split, join, strip, find, replace, etc.)
- Common dictionary patterns (keys, values, items, get, comprehensions)
- Loop patterns (for, while, enumerate, zip)
- Notes on scope, mutation vs. copy, and reference types

**Layout:** Flowing reference pages, no graph paper. Positioned after the solutions section.

---

### Part 1 — Warmups (15 problems) 🔲 *todo*

**Goal:** Easy mental warm-up, no writing space needed.

**Problem types:**
- Predict the output
- Loops, conditions, simple functions
- Lists, scope basics, mutation vs. copy

**Layout:** Single-column natural flow, each problem non-breakable.
Each problem shows: a code snippet + a small write-in box for predicted output.

**Estimated pages:** ~5 (1 title page + ~4 content pages)

---

### Part 2 — Write the Code (25 problems) 🔲 *todo*

Core section. Reader writes code by hand.

**Problem types:**
- FizzBuzz, sum/reverse lists, count values
- String problems, dictionary usage
- Simple recursion, binary search
- Real-world utility functions (filter, sort, map patterns)
- Edge cases

**Rule:** Must be solvable by a working developer without studying algorithms.

**Layout:** 1 problem per page with graph paper coding area.
Problems with long prompts automatically generate a second graph paper page.

**Estimated pages:** ~31 (25 problems + ~5 auto-added extra graph pages + 1 title page)

---

### Part 3 — Trace the Program (15 problems) 🔲 *todo*

Reader simulates execution step by step.

**Types:** Loop accumulation, list mutation, reference types, scope, chained function calls, higher-order functions, closures, dictionary operations, filter/map chains, conditional returns.

**Layout:** Single-column natural flow, each problem non-breakable. Each problem shows a code snippet + a small write-in box for predicted output.

**Estimated pages:** ~5 (1 title page + ~4 content pages)

---

### Part 4 — Find the Bug (15 problems) 🔲 *todo*

Reader identifies and explains the bug in a short code snippet, then rewrites the fix.

**Types:** Off-by-one, missing return, wrong key, accidental mutation, assignment vs. comparison, missing accumulation, missing branch, wrong indentation, mutable default argument, missing return in conditional.

**Layout:** 1 per page — buggy code + write-in space for explanation and fix. ~16 pages.

---

### Part 5 — Challenge Problems (5 problems) 🔲 *todo*

Harder but still realistic. Write-the-code format with graph paper. Still follows the "no algorithms" rule.

**Problem types:** frequency maps, flattening lists, filtering and formatting, grouping by property, deduplication, multi-rule validation, aggregation with sorting, recursion.

**Layout:** 1 problem per page with graph paper coding area. Same template as Part 2.

**Estimated pages:** ~6 (1 title page + ~5 problems)


---

### Solutions (~30 pages)

Code-only solutions, flowing inline (~3 per page).

Order in back matter mirrors section order: Warmup answers → Code Answers → Trace answers → Find the Bug answers → Challenge answers.

---

## Page Count Estimate

| Section | Pages |
|---|---|
| Front matter | 5 |
| Part 1 — Warmups | 5 |
| Part 2 — Write the Code | 31 |
| Part 3 — Trace the Program | 5 |
| Part 4 — Find the Bug | 16 |
| Part 5 — Challenge Problems | 6 |
| Solutions | 25 |
| **Total** | **~93** |

Fits within KDP standard page count range.

---

## Writing Grid

Code sections use **square graph paper** (fine grid, light gray lines, rounded border).

- Feels like a coding notebook
- Makes indentation natural
- Long problems auto-generate a second graph paper page

---

## Technical Stack (Python Edition)

- **Typst** for layout and PDF generation
- **Python** scripts to generate `.typ` files from CSV data sources
- **CSV files** as the source of truth for problem content
- Compiled to PDF via `typst compile book/book.typ`

**Data files:**
- `data/warmup.csv` — Part 1 problems
- `data/write-the-code.csv` — Part 2 problems
- `data/trace_problems_v3.csv` — Part 3 problems
- `data/find_the_bug_v2.csv` — Part 4 problems
- `data/challenge.csv` — Part 5 problems

**Generator scripts:**
- `scripts/generate_warmup.py`
- `scripts/generate_write_the_code.py`
- `scripts/generate_trace.py`
- `scripts/generate_find_the_bug.py`
- `scripts/generate_challenge.py`
