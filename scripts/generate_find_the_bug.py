"""
Generate Typst problem files for the Find the Bug section.

Reads data/find-the-bug.csv and writes:
  book/problems/find-the-bug/problem-001.typ  (one per row)
  book/sections/find-the-bug.typ
  book/sections/find-the-bug-answers.typ
"""

import csv
import pathlib

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent
CSV_PATH = REPO_ROOT / "data" / "find_the_bug_v2.csv"
PROBLEMS_DIR = REPO_ROOT / "book" / "problems" / "find-the-bug"
SECTIONS_DIR = REPO_ROOT / "book" / "sections"

TYPST_ESCAPE = str.maketrans({"#": r"\#", "@": r"\@", "<": r"\<", ">": r"\>", "*": r"\*"})


def escape_content(text: str) -> str:
    """Escape Typst special characters in content blocks."""
    return text.translate(TYPST_ESCAPE)


def escape_string(text: str) -> str:
    """Escape a value for use inside a Typst double-quoted string."""
    return text.replace("\\", "\\\\").replace('"', '\\"')


def make_problem_typ(row: dict) -> str:
    num = int(row["number"])
    title = escape_string(row["title"])
    code = escape_string(row["code"])

    lines = [
        '#import "../../template.typ": find_the_bug',
        "",
        "#find_the_bug(",
        f"  number: {num},",
        f'  title: "{title}",',
        f'  code: "{code}",',
        ")",
        "",
    ]
    return "\n".join(lines)


def generate_answers(rows: list) -> None:
    lines = [
        '#import "../template.typ": bug_answer',
        "",
        "#pagebreak()",
        "= Find the Bug Answers",
        "",
    ]

    for row in rows:
        num = int(row["number"])
        title = escape_string(row["title"])
        bug = escape_content(row["bug_explanation"].strip())
        fix = escape_content(row["fix"].strip())
        lines += [
            "#bug_answer(",
            f"  number: {num},",
            f'  title: "{title}",',
            f"  bug: [{bug}],",
            f"  fix: [{fix}],",
            ")",
            "",
        ]

    lines.append("")

    out = SECTIONS_DIR / "find-the-bug-answers.typ"
    out.write_text("\n".join(lines), encoding="utf-8")
    print(f"  wrote {out.relative_to(REPO_ROOT)}")


def main():
    PROBLEMS_DIR.mkdir(parents=True, exist_ok=True)
    SECTIONS_DIR.mkdir(parents=True, exist_ok=True)

    with open(CSV_PATH, newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))

    problem_files = []
    for row in rows:
        num = int(row["number"])
        filename = f"problem-{num:03d}.typ"
        out_path = PROBLEMS_DIR / filename
        out_path.write_text(make_problem_typ(row), encoding="utf-8")
        problem_files.append(filename)
        print(f"  wrote {out_path.relative_to(REPO_ROOT)}")

    # sections/find-the-bug.typ
    section_lines = [
        '#import "../template.typ": find_the_bug',
        "",
        "#pagebreak()",
        "= Part 4 — Find the Bug",
        "#v(0.2em)",
        '#text(style: "italic")[For each program, find the bug. Explain what is wrong in the space provided. The graph area is optional — use it to rewrite a corrected version if you like.]',
        "",
    ]
    for fname in problem_files:
        section_lines.append(f'#include "../problems/find-the-bug/{fname}"')
    section_lines.append("")

    section_path = SECTIONS_DIR / "find-the-bug.typ"
    section_path.write_text("\n".join(section_lines), encoding="utf-8")
    print(f"  wrote {section_path.relative_to(REPO_ROOT)}")

    generate_answers(rows)

    print(f"\nDone — {len(rows)} find-the-bug problem files generated.")


if __name__ == "__main__":
    main()
