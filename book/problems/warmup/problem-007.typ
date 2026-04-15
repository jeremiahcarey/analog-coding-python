#import "../../template.typ": warmup_problem

#warmup_problem(
  number: 7,
  title: "Dict Mutation",
  concept: "dictionaries",
  code: "user = {\"name\": \"Ava\", \"age\": 30}
user[\"age\"] = user[\"age\"] + 1

print(user[\"age\"])",
)
