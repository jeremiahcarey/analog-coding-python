Python Workbook – Revised Stage 1 Audit & Plan
Guiding Principle

This is not a translation.
This is a Python workbook built on the conceptual backbone of the JavaScript edition, rewritten to reflect Python’s natural idioms, strengths, and common pitfalls.

Legend
D (Direct) → Concept + structure port cleanly with minimal change
A (Adapt) → Same concept, but must be rewritten to feel natural in Python
R (Replace) → JS-specific → replace with Python-native concept
Updated Audit
Warmup
#	Title	Type	Notes
1	Reassignment	A	Minor rewrite; keep simple state reasoning
2	Mixed Types	R	Replace with truthiness
3	Loop Boundary	D	Direct
4	Array Index	D	Direct
5	Array Mutation	D	Direct
6	Function Return	D	Direct
7	The Silent Function	A	undefined → None
8	Two Variables	D	Direct
9	Object Mutation	A	Dict syntax + clearer mutation semantics
10	Equality	R	Replace with is vs ==
11	push + length	A	append + len
12	map	A	Prefer comprehension
13	filter + length	A	Prefer comprehension
14	Shared Array	A	Explicit aliasing (list behavior differs subtly)
15	Going Independent	A	Copy semantics ([:], list())
Key Insight

Warmups are the only section requiring real redesign, not just translation.

Trace the Program
#	Title	Type	Notes
1	Shared Array	D	Direct
2	Object Update Inside Function	D	Direct
3	Scope and Shadowing	D	Direct
4	Two Counters	A	Requires design choice (see below)
5	Score Filter	D	Direct
6	Team Score	D	Direct
7	Nested Totals	D	Direct
8	Item Formatter	D	Direct
9	Inventory Updates	A	Rewrite pipeline idiom
10	Player Scores	D	Direct
11	Todo Actions	D	Direct
12	Shopping Cart	D	Direct
13	Turn-Based Game	D	Direct
14	User Data Pipeline	A	Avoid side-effect map style
15	Project Task Runner	D	Direct
Design Decision: Two Counters

Prefer class-based state over nonlocal:

class Counter:
    def __init__(self):
        self.count = 0

    def increment(self):
        self.count += 1
        return self.count

Principle: Prefer clarity of state over closure cleverness.

Find the Bug
#	Title	Type	Notes
1	Sum Array	D	Direct
2	Age Check	D	Direct
3	Update Score	D	Direct
4	Find Negative	D	Direct
5	Item Label	D	Direct
6	Stock Check	D	Direct
7	Clear List	A → Upgrade	Replace with Python-specific bug
8	Neighbor Sums	D	Direct
9	Score Bonus	D	Direct
10	Filter Todos	A	Use comprehension
11	Order Total	D	Direct
12	Active Users	A	Pythonic rewrite
13	Inventory Manager	D	Direct
14	Game Turn	D	Direct
15	Project Task Runner	D	Direct
Upgrade Opportunity (Important)

Replace or enhance one problem with a Python-native bug:

Mutable default argument
def add_item(item, lst=[]):
    lst.append(item)
    return lst
Alternative (also strong)
grid = [[0] * 3] * 3
grid[0][0] = 1

These are signature Python mistakes — high teaching value.

Write the Code
#	Title	Type	Notes
1	FizzBuzz	D	Direct
2	Sum of an Array	D	Direct
3	Find the Largest Number	D	Direct
4	Count Even Numbers	D	Direct
5	Reverse a String	D	Direct
6	Count Vowels	D	Direct
7	Find the First Negative Number	D	Direct
8	Remove Empty Strings	D	Direct
9	Find User by ID	A	Use next() or loop
10	Get Sorted Names	A	sorted(..., key=...)
11	Active Usernames	A	Comprehension
12	Count Occurrences	D	Direct
13	Remove Duplicates	D	Direct
14	Check if Palindrome	D	Direct
15	Find the Longest Word	D	Direct
16	Capitalize Each Word	D	Direct
17	Count Word Frequencies	D	Direct
18	Two Sum	D	Direct
19	Get Names from Objects	A	Comprehension
20	Filter Objects	A	Comprehension
21	Sum Property Values	D	Direct
22	Group Objects	D	Direct
23	Total In-Stock Price	A	Loop/generator
24	Sort Products by Price	A	Key function
25	Second Largest Number	D	Direct
Challenge
#	Title	Type	Notes
1	Binary Search	D	Direct
2	Merge Sorted Arrays	D	Direct
3	Balanced Parentheses	D	Direct
4	Totals by Category	D	Direct
5	Flatten Recursive	D	Direct
Updated Totals
Direct: ~52
Adapt: ~21
Replace: 2

(Shift reflects reclassifying mutation/aliasing items as Adapt)

Structural Changes (Important)
Rename subsection: “Built-in Methods”
JS Version:
.map()
.filter()
.sort()
Python Version:

These are not equivalent culturally.

Replace with:
“Pythonic Patterns” (recommended)
or “Comprehensions and Sorting”
Concepts to emphasize:
list comprehensions
sorted(..., key=...)
next(...)
any, all
zip, enumerate (optional)

Focus shifts from APIs → patterns of thinking

Warmup Redesign Plan

Warmups should explicitly introduce Python mental models.

Replace JS-specific items with:
1. Truthiness
bool([])
bool([0])
bool("")
2. Identity vs Equality
a = [1, 2]
b = [1, 2]

a == b
a is b
3. Division behavior (new addition)
5 / 2
5 // 2
Additional Warmup Concepts to Emphasize
None vs falsy values
list aliasing vs copying
mutation vs reassignment
in keyword
slicing basics
Execution Plan (Stage 2+)
Step 1 — Redesign Warmups (Highest Priority)
Do not translate directly
Rebuild with Python-native concepts
Use JS set only as loose inspiration
Step 2 — Port Direct Problems
Warmups excluded
Minimal rewrite
Focus on correctness + clarity
Step 3 — Rewrite Adapt Problems
Convert:
map/filter → comprehensions
comparator → key=
object access → dict access
Ensure natural Python style
Step 4 — Upgrade Bug Section
Add at least one:
mutable default arg
aliasing bug
Ensure strong Python identity
Step 5 — Adjust Section Framing
Rename “Built-in Methods”
Emphasize patterns over APIs
Step 6 — Appendix (Python Version)

Include:

function syntax
loops (for, range)
conditionals
lists / dicts / sets
truthiness
comprehensions
sorting with key=
mutation vs copying
Final Take
The workbook is highly portable
The real work is tone alignment, not content creation
Python version can be:
faster to produce
cleaner conceptually
more cohesive if leaned into properly