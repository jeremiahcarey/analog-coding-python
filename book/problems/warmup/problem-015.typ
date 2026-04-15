#import "../../template.typ": warmup_problem

#warmup_problem(
  number: 15,
  title: "Filtering with a Comprehension",
  concept: "comprehensions",
  code: "nums = [1, 2, 3, 4, 5, 6]
evens = [n for n in nums if n % 2 == 0]

print(len(evens))
print(evens)",
)
