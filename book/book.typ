#import "template.typ": *

#set page(
  width: 7in,
  height: 10in,
  margin: 0.75in,
  numbering: "1",
  number-align: bottom + center,
)
#set text(
  font: "Liberation Serif",
  size: 11pt,
)
#set par(leading: 0.85em)
#set heading(numbering: none)
#show heading.where(level: 2): it => {
  v(1.2em)
  text(size: 14pt, weight: "bold", it.body)
  v(0.2em)
}
#show heading.where(level: 3): it => {
  v(0.6em)
  text(size: 11pt, weight: "bold", style: "italic", it.body)
  v(0.1em)
}

#include "sections/title-page.typ"
#include "sections/copyright.typ"
#include "sections/dedication.typ"
#include "sections/toc.typ"
#include "sections/introduction.typ"
#include "sections/warmup.typ"
#include "sections/write-the-code.typ"
#include "sections/trace-the-program.typ"
#include "sections/find-the-bug.typ"
#include "sections/challenge.typ"
#include "sections/solutions-divider.typ"
#include "sections/warmup-answers.typ"
#include "sections/solutions.typ"
#include "sections/trace-answers.typ"
#include "sections/find-the-bug-answers.typ"
#include "sections/challenge-answers.typ"
#include "sections/appendix.typ"
