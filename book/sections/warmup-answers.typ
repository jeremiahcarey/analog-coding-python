#import "../template.typ": predict_answer

#pagebreak()
= Warmup Answers

#columns(2, gutter: 0.4in)[
  #predict_answer(
    number: 1,
    title: "Reassignment",
    output: "21",
  )

  #predict_answer(
    number: 2,
    title: "Loop Boundary",
    output: "6",
  )

  #predict_answer(
    number: 3,
    title: "List Mutation",
    output: "[1, 99, 3]",
  )

  #predict_answer(
    number: 4,
    title: "Function Return",
    output: "8",
  )

  #predict_answer(
    number: 5,
    title: "The Greeting",
    output: "None",
  )

  #predict_answer(
    number: 6,
    title: "Two Variables",
    output: "8
3",
  )

  #predict_answer(
    number: 7,
    title: "Dict Mutation",
    output: "31",
  )

  #predict_answer(
    number: 8,
    title: "Shared List",
    output: "[1, 2, 3]
[1, 2, 3]",
  )

  #predict_answer(
    number: 9,
    title: "Going Independent",
    output: "[1, 2]
[1, 2, 3]",
  )

  #predict_answer(
    number: 10,
    title: "Truthiness",
    output: "False
True
False
True",
  )

  #predict_answer(
    number: 11,
    title: "Equality vs Identity",
    output: "True
False
True",
  )

  #predict_answer(
    number: 12,
    title: "Division",
    output: "2.5
2",
  )

  #predict_answer(
    number: 13,
    title: "append + len",
    output: "3
['Ana', 'Ben', 'Chris']",
  )

  #predict_answer(
    number: 14,
    title: "List Comprehension",
    output: "[2, 4, 6, 8]",
  )

  #predict_answer(
    number: 15,
    title: "Filtering with a Comprehension",
    output: "3
[2, 4, 6]",
  )

]
