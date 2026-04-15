"""
Generate Typst problem files for the Warmup section.

Reads data/warmup.csv and writes:
  book/problems/warmup/problem-001.typ  (one per row)
  book/sections/warmup.typ
  book/sections/warmup-answers.typ
"""

import csv
import pathlib

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent
CSV_PATH = REPO_ROOT / "data" / "warmup.csv"
PROBLEMS_DIR = REPO_ROOT / "book" / "problems" / "warmup"
SECTIONS_DIR = REPO_ROOT / "book" / "sections"


def escape_string(text: str) -> str:
    """Escape a value for use inside a Typst double-quoted string."""
    return text.replace("\\", "\\\\").replace('"', '\\"')


def make_problem_typ(row: dict) -> str:
    num = int(row["id"])
    title = escape_string(row["title"])
    concept = escape_string(row["concept"])
    code = escape_string(row["code"])

    lines = [
        '#import "../../template.typ": warmup_problem',
        "",
        "#warmup_problem(",
        f"  number: {num},",
        f'  title: "{title}",',
        f'  concept: "{concept}",',
        f'  code: "{code}",',
        ")",
        "",
    ]
    return "\n".join(lines)


def generate_answers(rows: list) -> None:
    """Write book/sections/warmup-answers.typ."""
    lines = [
        '#import "../template.typ": predict_answer',
        "",
        "#pagebreak()",
        "= Warmup Answers",
        "",
        "#columns(2, gutter: 0.4in)[",
    ]

    for row in rows:
        num = int(row["id"])
        title = escape_string(row["title"])
        output = escape_string(row["output"].strip())
        lines += [
            "  #predict_answer(",
            f"    number: {num},",
            f'    title: "{title}",',
            f'    output: "{output}",',
            "  )",
            "",
        ]

    lines += ["]", ""]

    answers_path = SECTIONS_DIR / "warmup-answers.typ"
    answers_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"  wrote {answers_path.relative_to(REPO_ROOT)}")


def main():
    PROBLEMS_DIR.mkdir(parents=True, exist_ok=True)
    SECTIONS_DIR.mkdir(parents=True, exist_ok=True)

    with open(CSV_PATH, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    problem_files = []

    for row in rows:
        num = int(row["id"])
        filename = f"problem-{num:03d}.typ"
        out_path = PROBLEMS_DIR / filename
        content = make_problem_typ(row)
        out_path.write_text(content, encoding="utf-8")
        problem_files.append(filename)
        print(f"  wrote {out_path.relative_to(REPO_ROOT)}")

    # sections/warmup.typ
    section_lines = [
        '#import "../template.typ": warmup_problem',
        "",
        "= Part 1 — Warmups",
        "#v(0.2em)",
        '#text(style: "italic")[Predict the output of each program without running the code.]',
        "#pagebreak()",
        "",
    ]
    for fname in problem_files:
        section_lines.append(f'#include "../problems/warmup/{fname}"')
    section_lines.append("")

    section_path = SECTIONS_DIR / "warmup.typ"
    section_path.write_text("\n".join(section_lines), encoding="utf-8")
    print(f"  wrote {section_path.relative_to(REPO_ROOT)}")

    # sections/warmup-answers.typ
    generate_answers(rows)

    print(f"\nDone — {len(rows)} warmup problem files generated.")


if __name__ == "__main__":
    main()
