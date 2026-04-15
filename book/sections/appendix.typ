#pagebreak()
#heading(level: 1, outlined: false)[Appendix]
#pagebreak()

= Appendix

This appendix contains a brief reference for common Python syntax and methods.
It is not a full guide to the language — only the most commonly needed features for solving the problems in this workbook are included.

== Function Syntax

=== Function definition

```python
def add(a, b):
    return a + b
```

=== Default parameters

```python
def greet(name="Guest"):
    return "Hello, " + name
```

=== Lambda (anonymous function)

```python
add = lambda a, b: a + b
```

== Conditionals and Operators

=== if / elif / else

```python
if x > 10:
    print("big")
elif x > 5:
    print("medium")
else:
    print("small")
```

=== Comparison operators

```
==    equal
!=    not equal
>     greater than
<     less than
>=    greater or equal
<=    less or equal
```

=== Logical operators

```
and   both conditions true
or    at least one true
not   negation
```

Example:

```python
if age > 18 and is_member:
    pass
```

=== Ternary expression

```python
result = "big" if x > 10 else "small"
```

=== Falsy values

```
False
0
0.0
""
None
[]
{}
```

Everything else is truthy.

== Loop Syntax

=== for loop (range)

```python
for i in range(5):
    print(i)
```

=== for loop (list)

```python
for value in my_list:
    print(value)
```

=== while loop

```python
i = 0
while i < 5:
    print(i)
    i += 1
```

=== enumerate (index + value)

```python
for i, value in enumerate(my_list):
    print(i, value)
```

=== break / continue

```python
for x in my_list:
    if x == 5:
        break

for x in my_list:
    if x < 0:
        continue
    print(x)
```

== List Methods

=== Adding / removing

```python
lst.append(x)       # mutates — adds to end
lst.pop()           # mutates — removes and returns last item
lst.pop(i)          # mutates — removes and returns item at index i
lst.insert(i, x)    # mutates — inserts x at index i
lst.remove(x)       # mutates — removes first occurrence of x
```

=== Searching

```python
x in lst            # returns boolean
lst.index(x)        # returns index, raises ValueError if not found
lst.count(x)        # returns number of occurrences
```

=== Copying / slicing

```python
lst[start:end]      # new list — does not mutate
lst[:]              # full copy
lst.copy()          # full copy
```

=== Sorting

`sort()` *mutates the original list*. `sorted()` returns a new list.

```python
lst.sort()                        # mutates — ascending
lst.sort(reverse=True)            # mutates — descending
lst.sort(key=lambda x: x[1])     # mutates — custom key

sorted(lst)                       # returns new list — does not mutate
sorted(lst, reverse=True)
sorted(lst, key=lambda x: x[1])
```

=== Other

```python
len(lst)            # length
sum(lst)            # sum of numeric items
min(lst)            # minimum
max(lst)            # maximum
lst.reverse()       # mutates — reverses in place
list(reversed(lst)) # returns new reversed list
```

=== List comprehensions

```python
squares = [x * x for x in range(10)]

evens = [x for x in lst if x % 2 == 0]
```

== String Methods

=== Length

```python
len(s)
```

=== Searching

```python
"a" in s
s.startswith("a")
s.endswith("a")
s.find("a")         # returns index, or -1 if not found
s.index("a")        # returns index, raises ValueError if not found
```

=== Slicing

```python
s[1:4]
s[:3]
s[-1]               # last character
```

=== Case

```python
s.lower()
s.upper()
```

=== Trimming

```python
s.strip()
s.lstrip()
s.rstrip()
```

=== Splitting / joining

```python
s.split(",")
",".join(lst)
```

=== Replace

```python
s.replace("a", "b")
```

=== Check content

```python
s.isdigit()
s.isalpha()
s.isalnum()
```

== Dictionary Syntax and Methods

=== Dictionary literal

```python
user = {
    "name": "Alice",
    "age": 30
}
```

=== Accessing values

```python
user["name"]
user.get("name")           # returns None if key missing
user.get("name", "Guest")  # returns default if key missing
```

=== Adding / updating

```python
user["age"] = 31
user["city"] = "NY"
```

=== Checking for a key

```python
if "name" in user:
    pass
```

=== Keys / values / items

```python
user.keys()
user.values()
user.items()
```

Iterating:

```python
for key, value in user.items():
    print(key, value)
```

=== Removing

```python
del user["age"]
user.pop("age")             # removes and returns value
user.pop("age", None)       # safe — returns None if missing
```

=== Dictionary comprehension

```python
squares = {x: x * x for x in range(5)}
```

== Useful Built-in Functions

```python
range(n)            # 0 to n-1
range(a, b)         # a to b-1
range(a, b, step)   # with step

abs(x)              # absolute value
round(x, n)         # round to n decimal places

type(x)             # type of x
isinstance(x, int)  # type check

zip(a, b)           # pair up two iterables
map(fn, lst)        # apply function to each item — returns iterator
filter(fn, lst)     # filter items — returns iterator
any(lst)            # True if any item is truthy
all(lst)            # True if all items are truthy
```

== Common Patterns

=== Swap two variables

```python
a, b = b, a
```

=== Unpack a list

```python
first, *rest = lst
*rest, last = lst
first, *middle, last = lst
```

=== Count occurrences with a dict

```python
counts = {}
for item in lst:
    counts[item] = counts.get(item, 0) + 1
```

=== Flatten a list of lists

```python
flat = [x for sublist in nested for x in sublist]
```

=== Check if a number is even/odd

```python
x % 2 == 0   # even
x % 2 != 0   # odd
```
