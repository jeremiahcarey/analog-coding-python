"""
Generate Typst problem files for the Trace the Program section.

Reads data/trace_problems.csv and writes:
  book/problems/trace/problem-001.typ  (one per row)
  book/sections/trace-the-program.typ
  book/sections/trace-answers.typ
"""

import csv
import pathlib

REPO_ROOT = pathlib.Path(__file__).resolve().parent.parent
CSV_PATH = REPO_ROOT / "data" / "trace_problems_v3.csv"
PROBLEMS_DIR = REPO_ROOT / "book" / "problems" / "trace"
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
        '#import "../../template.typ": trace_problem',
        "",
        "#trace_problem(",
        f"  number: {num},",
        f'  title: "{title}",',
        f'  code: "{code}",',
        ")",
        "",
    ]
    return "\n".join(lines)


def generate_answers(rows: list) -> None:
    lines = [
        '#import "../template.typ": predict_answer',
        "",
        "#pagebreak()",
        "= Trace Answers",
        "",
        "#columns(2, gutter: 0.4in)[",
    ]

    for row in rows:
        num = int(row["number"])
        title = escape_string(row["title"])
        output = escape_string(row["answer"].strip())
        explanation = escape_content(row["explanation"].strip())
        lines += [
            "  #predict_answer(",
            f"    number: {num},",
            f'    title: "{title}",',
            f'    output: "{output}",',
            f"    explanation: [{explanation}],",
            "  )",
            "",
        ]

    lines += ["]", ""]

    out = SECTIONS_DIR / "trace-answers.typ"
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

    # sections/trace-the-program.typ
    section_lines = [
        '#import "../template.typ": trace_problem',
        "",
        "#pagebreak()",
        "= Part 3 — Trace the Program",
        "#v(0.2em)",
        '#text(style: "italic")[For each program, trace the execution and write the output in the space provided.]',
        "#pagebreak()",
        "",
    ]
    for fname in problem_files:
        section_lines.append(f'#include "../problems/trace/{fname}"')
    section_lines.append("")

    section_path = SECTIONS_DIR / "trace-the-program.typ"
    section_path.write_text("\n".join(section_lines), encoding="utf-8")
    print(f"  wrote {section_path.relative_to(REPO_ROOT)}")

    generate_answers(rows)

    print(f"\nDone — {len(rows)} trace problem files generated.")


if __name__ == "__main__":
    main()
