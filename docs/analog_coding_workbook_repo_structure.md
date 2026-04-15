# Analog Coding Workbook — Repo and File Structure

This document outlines a recommended repository structure for **The Analog Coding Workbook** project, based on the current plan for the JavaScript edition and designed to scale to future editions.

## Current Book Structure

The current planned order of the book is:

1. Front matter
2. Warmups
3. Write the Code
4. Find the Bug
5. Trace the Program
6. Challenge Problems
7. Appendix
8. Solutions

## Goals of This Structure

The repository should make it easy to:

- keep source material organized
- separate reusable templates from generated problem files
- store spreadsheet/question data cleanly
- generate pages automatically later
- compile the full book from a single master file
- revise sections independently
- scale to future books in the series

## Recommended Repo Structure

```text
analog-coding-workbook-py/
├── README.md
├── book.typ
├── template.typ
├── front-matter.typ
├── appendix.typ
├── solutions.typ
├── data/
│   ├── write-the-code.csv
│   ├── write-the-code.xlsx
│   ├── find-the-bug.csv
│   ├── trace-the-program.csv
│   └── challenge-problems.csv
├── sections/
│   ├── warmups.typ
│   ├── write-the-code.typ
│   ├── find-the-bug.typ
│   ├── trace-the-program.typ
│   ├── challenge-problems.typ
│   └── section-divider.typ
├── problems/
│   ├── warmups/
│   │   ├── warmup-001.typ
│   │   ├── warmup-002.typ
│   │   └── ...
│   ├── write-the-code/
│   │   ├── problem-001.typ
│   │   ├── problem-002.typ
│   │   └── ...
│   ├── find-the-bug/
│   │   ├── bug-001.typ
│   │   ├── bug-002.typ
│   │   └── ...
│   ├── trace-the-program/
│   │   ├── trace-001.typ
│   │   ├── trace-002.typ
│   │   └── ...
│   └── challenge-problems/
│       ├── challenge-001.typ
│       ├── challenge-002.typ
│       └── ...
├── scripts/
│   ├── generate_write_the_code.py
│   ├── generate_find_the_bug.py
│   ├── generate_trace_the_program.py
│   ├── generate_challenge_problems.py
│   └── build_book.py
├── assets/
│   ├── cover/
│   ├── images/
│   └── fonts/
├── exports/
│   ├── draft/
│   └── final/
└── notes/
    ├── layout-notes.md
    ├── production-plan.md
    └── section-ideas.md
```

## What Each Top-Level File or Folder Is For

### `README.md`

A simple overview of the repo. It can include:

- what the project is
- how to compile the book
- where the source data lives
- how generation scripts work
- naming conventions

### `book.typ`

This is the **master Typst file** for the whole book.

Its job is to pull everything together in the correct order, for example:

- front matter
- section title pages
- all problem pages
- appendix
- solutions

This file should become the main compile target.

### `template.typ`

This is the shared template file for page layouts and reusable helpers.

It should contain things like:

- page setup
- text styling
- shared spacing rules
- graph-paper box
- `coding_problem_page(...)`
- future templates such as:
  - `bug_finding_page(...)`
  - `trace_page(...)`
  - `challenge_page(...)`
  - `section_divider_page(...)`

For now, keeping all shared templates in one file is a good approach. If the file grows too large later, it can be split.

### `front-matter.typ`

This should contain the opening pages, such as:

- title page
- copyright page
- introduction
- how to use this workbook
- difficulty guide
- optional table of contents

### `appendix.typ`

This can hold supporting reference material, such as:

- brief Python syntax reminders
- common list methods
- common string methods
- notes on dictionaries, loops, conditionals, etc.
- any mini reference sheet you want readers to use analog-style

### `solutions.typ`

This can either contain all solutions directly or include generated solution pages from elsewhere.

A good long-term option is to generate solution pages separately and then include them here.

## The `data/` Folder

This contains structured source data, such as CSV or Excel files.

For example:

- question titles
- full prompts
- starter code
- hints
- answers
- difficulty
- page type
- section membership

This folder is the best place to store the spreadsheet exports that drive automated page generation.

Example files:

- `write-the-code.xlsx`
- `find-the-bug.csv`
- `trace-the-program.csv`

## The `sections/` Folder

This folder should contain Typst files that define section-level structure.

These may include:

- section title pages
- a short intro paragraph for each section
- includes for all pages in that section

For example, `write-the-code.typ` might:

- render a section divider
- include all generated files from `problems/write-the-code/`

This is useful because it lets `book.typ` stay clean and high-level.

## The `problems/` Folder

This is where the actual generated problem page files should live.

Splitting them by section makes the project much easier to manage.

For example:

- `problems/write-the-code/problem-001.typ`
- `problems/find-the-bug/bug-003.typ`
- `problems/trace-the-program/trace-005.typ`

This structure gives you:

- easy navigation
- clean regeneration by section
- lower risk of naming confusion
- simpler script logic

## The `scripts/` Folder

This should contain Python scripts that automate production tasks.

Likely scripts include:

- generating problem pages from spreadsheets
- rebuilding section include files
- producing solution pages
- validating data
- compiling or exporting the full draft

You may begin with one script and split later.

Example progression:

- first: one simple `generate_write_the_code.py`
- later: one general script that handles all page types

## The `assets/` Folder

This is for non-Typst resources used by the book.

Typical contents:

- cover files
- logo or branding graphics
- decorative images
- any custom fonts you choose to package with the project

If you stay with standard fonts, this folder may stay small at first.

## The `exports/` Folder

This is where compiled PDFs can go.

A useful structure is:

- `exports/draft/` for working proofs
- `exports/final/` for release candidates or publication files

This makes it easier to distinguish between quick tests and serious print-ready exports.

## The `notes/` Folder

This is for informal planning documents, such as:

- layout ideas
- publishing checklist
- KDP notes
- problem selection notes
- future edition ideas

This folder is optional, but very useful for a project like this.

## Suggested Build Flow

The intended production flow would look something like this:

```text
spreadsheet data
  -> generation script
  -> section problem files
  -> section include files
  -> book.typ
  -> compiled PDF
```

More concretely:

```text
data/write-the-code.xlsx
  -> scripts/generate_write_the_code.py
  -> problems/write-the-code/problem-001.typ
  -> problems/write-the-code/problem-002.typ
  -> sections/write-the-code.typ
  -> book.typ
  -> exports/draft/workbook-draft.pdf
```

## Suggested Early Milestone

A very good first repo version would include only:

- `template.typ`
- `book.typ`
- `front-matter.typ`
- `sections/write-the-code.typ`
- 2–3 hand-made problem files
- the current spreadsheet in `data/`

That is enough to validate the structure before you automate everything.

## Naming Guidance

A few naming rules that should help:

- Use lowercase file names
- Prefer hyphens or underscores consistently
- Keep section names aligned with folder names
- Use zero-padded numbers if you want easier sorting, for example:
  - `problem-001.typ`
  - `problem-002.typ`

## Final Recommendation

This structure is intentionally a little more organized than absolutely necessary, because the project is not just a document — it is a repeatable **book production system**.

For now, the most important pieces are:

- one shared `template.typ`
- one master `book.typ`
- section-based folders for generated pages
- spreadsheet data stored in `data/`
- a place for scripts as soon as automation begins

That should give you a clean foundation for the Python edition and make future books much easier to produce.
