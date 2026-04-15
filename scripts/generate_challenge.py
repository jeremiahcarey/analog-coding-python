"""
Generate Typst problem files for the Challenge section.

Reads data/challenge.csv and writes:
  book/problems/challenge/problem-001.typ  (one per row)
  book/sections/challenge.typ
  book/sections/challenge-answers.typ
"""

import csv
import pathlib

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent
CSV_PATH = REPO_ROOT / "data" / "challenge.csv"
PROBLEMS_DIR = REPO_ROOT / "book" / "problems" / "challenge"
SECTIONS_DIR = REPO_ROOT / "book" / "sections"

TYPST_ESCAPE = str.maketrans({
    "#": r"\#",
    "@": r"\@",
    "<": r"\<",
    ">": r"\>",
})


def escape_content(text: str) -> str:
    """Escape Typst special characters in content blocks."""
    return text.translate(TYPST_ESCAPE)


def escape_string(text: str) -> str:
    """Escape a value for use inside a Typst double-quoted string."""
    return text.replace("\\", "\\\\").replace('"', '\\"')


def make_problem_typ(row: dict) -> str:
    num = int(row["id"])
    title = escape_string(row["title"])
    difficulty = escape_string(row["difficulty"])
    prompt_text = escape_content(row["prompt_full"])
    stub = escape_string(row["stub_code"])
    hint_raw = row["hint"].strip()

    if hint_raw:
        hint_arg = f'  hint: "{escape_string(hint_raw)}",\n'
    else:
        hint_arg = ""

    lines = [
        '#import "../../template.typ": coding_problem_page',
        "",
        "#coding_problem_page(",
        f"  number: {num},",
        f'  title: "{title}",',
        f'  difficulty: "{difficulty}",',
        "  prompt: [",
    ]

    for line in prompt_text.splitlines():
        lines.append(f"    {line}" if line.strip() else "")

    lines += [
        "  ],",
        f'  signature: "{stub}",',
    ]

    if hint_arg:
        lines.append(hint_arg.rstrip("\n"))

    lines.append(")")
    lines.append("")

    return "\n".join(lines)


def generate_solutions(rows: list) -> None:
    """Write book/sections/challenge-answers.typ."""
    lines = [
        '#import "../template.typ": solution_block',
        "",
        "#pagebreak()",
        "= Challenge Answers",
        "",
    ]

    for row in rows:
        num = int(row["id"])
        title = escape_string(row["title"])
        difficulty = escape_string(row["difficulty"])
        answer = escape_string(row["answer"].strip())

        lines += [
            "#solution_block(",
            f"  number: {num},",
            f'  title: "{title}",',
            f'  difficulty: "{difficulty}",',
            f'  answer: "{answer}",',
            ")",
            "",
        ]

    sol_path = SECTIONS_DIR / "challenge-answers.typ"
    sol_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"  wrote {sol_path.relative_to(REPO_ROOT)}")


def main():
    PROBLEMS_DIR.mkdir(parents=True, exist_ok=True)
    SECTIONS_DIR.mkdir(parents=True, exist_ok=True)

    with open(CSV_PATH, newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))

    problem_files = []

    for row in rows:
        num = int(row["id"])
        filename = f"problem-{num:03d}.typ"
        out_path = PROBLEMS_DIR / filename
        out_path.write_text(make_problem_typ(row), encoding="utf-8")
        problem_files.append(filename)
        print(f"  wrote {out_path.relative_to(REPO_ROOT)}")

    # sections/challenge.typ
    section_lines = [
        "#pagebreak()",
        "= Part 5 — Challenge Problems",
        "#v(0.2em)",
        '#text(style: "italic")[These problems may require more planning and more careful handling of edge cases.]',
        "",
    ]
    for fname in problem_files:
        section_lines.append(f'#include "../problems/challenge/{fname}"')
    section_lines.append("")

    section_path = SECTIONS_DIR / "challenge.typ"
    section_path.write_text("\n".join(section_lines), encoding="utf-8")
    print(f"  wrote {section_path.relative_to(REPO_ROOT)}")

    generate_solutions(rows)

    print(f"\nDone — {len(rows)} challenge problem files generated.")


if __name__ == "__main__":
    main()
