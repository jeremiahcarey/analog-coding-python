#import "../../template.typ": warmup_problem

#warmup_problem(
  number: 11,
  title: "Equality vs Identity",
  concept: "equality",
  code: "a = [1, 2]
b = [1, 2]
c = a

print(a == b)
print(a is b)
print(a is c)",
)
