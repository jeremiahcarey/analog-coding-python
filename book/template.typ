#set page(
  width: 7in,
  height: 10in,
  margin: 0.75in,
)
#set text(
  font: "Liberation Serif",
  size: 11pt,
)
#set par(
  leading: 0.85em,
)
#set heading(
  numbering: none,
)

// =====================================
// Helpers
// =====================================

#let graph_box_fill() = {
  let cell_size = 0.18in
  let box_width = 7in - 2 * 0.75in
  let cols = calc.floor(box_width / cell_size)

  layout(size => {
    let rows = calc.floor(size.height / cell_size)
    block(
      width: 100%,
      height: size.height,
      stroke: 1pt + gray,
      radius: 6pt,
      clip: true,
    )[
      #grid(
        columns: (1fr,) * cols,
        rows: (1fr,) * rows,
        stroke: 0.3pt + luma(180),
        ..range(cols * rows).map(_ => [])
      )
    ]
  })
}

#let graph_box_fixed(h) = {
  let cell_size = 0.18in
  let grid_pattern = pattern(size: (cell_size, cell_size), relative: "self")[
    #place(line(start: (0pt, 0pt), end: (cell_size, 0pt), stroke: 0.3pt + luma(180)))
    #place(line(start: (0pt, 0pt), end: (0pt, cell_size), stroke: 0.3pt + luma(180)))
  ]
  rect(
    width: 100%,
    height: h,
    stroke: 1pt + gray,
    radius: 6pt,
    fill: grid_pattern,
  )
}

#let prompt_block(body) = body

#let example_block(body) = [
  *Example:*
  #v(0.35em)
  #body
]

#let constraints_block(items) = [
  *Constraints:*
  #for item in items [
    - #item
  ]
]

#let hint_block(content) = [
  #v(0.5em)
  #emph([Hint: #content])
]

// =====================================
// Trace the Program — problem block (natural flow, breakable: false)
// =====================================

#let trace_problem(
  number: none,
  title: none,
  code: "",
) = block(
  breakable: true,
  width: 100%,
  below: 1.1em,
)[
  #block(sticky: true)[
    === #number. #title
    #v(0.2em)
  ]
  #raw(code, lang: "python")
  #block(breakable: false)[
    #v(0.3em)
    *Output:*
    #v(0.15em)
    #rect(width: 100%, height: 0.75in, stroke: 0.5pt + luma(160), radius: 3pt)
  ]
]

// =====================================
// Warmup problem block (single-column flow, breakable: false)
// =====================================

#let warmup_problem(
  number: none,
  title: none,
  concept: none,
  code: "",
) = block(
  breakable: false,
  width: 100%,
  below: 1.1em,
)[
  === #number. #title
  #if concept != none [
    #text(size: 8pt, style: "italic", fill: luma(120))[#concept]
  ]
  #v(0.2em)
  #raw(code, lang: "python")
  #v(0.3em)
  *Output:*
  #v(0.15em)
  #rect(width: 100%, height: 0.75in, stroke: 0.5pt + luma(160), radius: 3pt)
]

// =====================================
// Answer blocks (used in all answer sections)
// =====================================

#let predict_answer(
  number: none,
  title: none,
  output: "",
  explanation: none,
) = block(breakable: false, below: 1.5em)[
  #set par(spacing: 0pt)
  *#number. #title*
  #v(0.6em)
  #pad(left: 0.5em)[
    *Answer:*
    #v(0.35em)
    #text(size: 10pt)[#raw(output)]
    #if explanation != none [
      #v(0.5em)
      #text(size: 9pt, style: "italic")[*Explanation:* #explanation]
    ]
  ]
]

#let bug_answer(
  number: none,
  title: none,
  bug: [],
  fix: [],
) = block(breakable: false, below: 1.5em)[
  #set par(spacing: 0pt)
  *#number. #title*
  #v(0.5em)
  #pad(left: 0.5em)[
    #text(size: 9pt, style: "italic")[*Bug:* #bug]
    #v(0.6em)
    #text(size: 9pt, style: "italic")[*Fix:* #fix]
  ]
]

// =====================================
// Find the Bug — problem page
// =====================================

#let find_the_bug(
  number: none,
  title: none,
  code: "",
  continuation_note: false,
) = {
  assert(number != none, message: "find_the_bug: number is required")
  assert(title != none, message: "find_the_bug: title is required")

  let code_block = raw(code, lang: "python")

  [
    #pagebreak()
    === #number. #title
    #v(0.2em)
    #code_block
    #v(0.3em)
    *Bug:*
    #v(0.15em)
    #rect(width: 100%, height: 0.75in, stroke: 0.5pt + luma(160), radius: 3pt)
    #v(0.5em)
    #if continuation_note [
      #v(0.5em)
      #align(center)[
        #text(size: 8pt, style: "italic", fill: luma(160))[Your fix will have its own space on the next page.]
      ]
      #v(0.5em)
    ]
    #block(sticky: true)[
      #text(style: "italic", size: 9pt)[Fix: (optional)]
      #v(0.25em)
    ]
    #context {
      let h = measure(code_block).height
      graph_box_fixed(calc.max(1.5in, calc.min(h, 4.5in)))
    }
  ]
}

// =====================================
// Solutions block (flows inline, multiple per page)
// =====================================

#let solution_block(
  number: none,
  title: none,
  difficulty: none,
  answer: "",
  answer_lang: "python",
  alt_answer: none,
  alt_label: "Alternative approach:",
) = [
  #assert(number != none, message: "solution_block: number is required")
  #assert(title != none, message: "solution_block: title is required")

  === #number. #title
  #if difficulty != none [
    #text(style: "italic", size: 9pt)[#difficulty]
  ]
  #v(0.25em)
  #raw(answer, lang: answer_lang)
  #if alt_answer != none [
    #v(0.5em)
    #text(style: "italic", size: 9pt)[#alt_label]
    #v(0.25em)
    #raw(alt_answer, lang: answer_lang)
  ]
  #v(1em)
]

// =====================================
// Extra graph paper page (for long problems)
// =====================================

#let graph_page(number: none, title: none) = page()[
  #grid(
    rows: (auto, 1fr),
    columns: 100%,
    gutter: 0pt,
    [
      === #number. #title (continued)
      #v(0.5em)
    ],
    graph_box_fill(),
  )
]

// =====================================
// Main coding problem template
// =====================================

#let coding_problem_page(
  number: none,
  title: none,
  prompt: none,
  section: none,
  difficulty: none,
  example: none,
  constraints: (),
  signature: "",
  signature_lang: "python",
  signature_heading: "Example signature",
  hint: none,
) = {
  assert(number != none, message: "coding_problem_page: number is required")
  assert(title != none, message: "coding_problem_page: title is required")
  assert(prompt != none, message: "coding_problem_page: prompt is required")

  let top_content = [
    === #number. #title
    #if difficulty != none [
      #text(style: "italic", size: 9pt)[#difficulty]
    ]
    #v(0.1em)

    #prompt_block(prompt)

    #if example != none [
      #v(0.5em)
      #example_block(example)
    ]

    #if constraints.len() > 0 [
      #v(0.5em)
      #constraints_block(constraints)
    ]

    #if signature != "" [
      #v(0.65em)
      *#signature_heading*
      #v(0.2em)
      #raw(signature, lang: signature_lang)
    ]

    #if hint != none [
      #hint_block(hint)
    ]

    #v(0.75em)
    *Write your solution below*
    #v(0.35em)
  ]

  page()[
    #grid(
      rows: (auto, 1fr),
      columns: 100%,
      gutter: 0pt,
      top_content,
      graph_box_fill(),
    )
  ]

  // Auto-add extra graph page if top content exceeds 50 % of text area
  context {
    let text_width  = 7in - 2 * 0.75in   // 5.5in
    let text_height = 10in - 2 * 0.75in  // 8.5in
    let measured    = measure(top_content, width: text_width)
    if measured.height > text_height * 0.5 {
      graph_page(number: number, title: title)
    }
  }
}

