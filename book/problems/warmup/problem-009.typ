#import "../../template.typ": warmup_problem

#warmup_problem(
  number: 9,
  title: "Going Independent",
  concept: "references",
  code: "a = [1, 2]
b = a[:]
b.append(3)

print(a)
print(b)",
)
