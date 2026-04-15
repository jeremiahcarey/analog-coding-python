#import "../../template.typ": warmup_problem

#warmup_problem(
  number: 10,
  title: "Truthiness",
  concept: "truthiness",
  code: "print(bool([]))
print(bool([0]))
print(bool(\"\"))
print(bool(\"hi\"))",
)
