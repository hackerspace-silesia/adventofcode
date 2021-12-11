import sys

scores = {
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137,
}

C = []
for line in sys.stdin:
    C.append(line.strip())

class Corrupted(Exception): pass
class Incomplete(Exception): pass

corrupted = []
completed = []
for line in C:
    stack = []
    skip = False
    for c in line:
        try:
            if c in '([{<':
                stack.append(c)
                continue

            # )]}>
            if not len(stack):
                raise Corrupted()

            last = stack.pop(-1)
            if last == '(' and c != ')':
                raise Corrupted()
            if last == '[' and c != ']':
                raise Corrupted()
            if last == '{' and c != '}':
                raise Corrupted()
            if last == '<' and c != '>':
                raise Corrupted()

        except Corrupted as e:
            corrupted.append(c)
            skip = True
            break
        except Exception as e:
            print(e)

    # Incoplete
    if len(stack) == 0 or skip: continue
    complete=[]
    for c in stack[::-1]:
        add=""
        if c == '(':
            add=')'
        if c == '[':
            add=']'
        if c == '{':
            add='}'
        if c == '<':
            add='>'
        complete.append(add)
    completed.append(complete)

print(sum(scores[c] for c in corrupted))

# part 2
scores = {
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4,
}

import functools as ft
res = sorted(ft.reduce(lambda x,y: x*5+scores[y], [0] + l) for l in completed)
print(res[len(res)//2])
