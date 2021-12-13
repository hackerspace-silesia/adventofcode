import sys
from collections import defaultdict as dd

C = dd(list)
for line in sys.stdin:
    start, stop = line.strip().split("-")
    C[start].append(stop)
    C[stop].append(start)

# part 1
def search(C, path, visited):
    count = 0
    last = path[-1]
    edges = C[last]
    if last.islower():
        visited[last] = True
    for e in edges:
        if e in visited: continue
        if e == 'end':
            count += 1
            continue
        count += search(C, path+[e], visited.copy())
    return count

paths=search(C, ['start'], {})
print(paths)

# part 2
def search(C, last, visited, twice):
    paths = 0
    edges = C[last]
    if last.islower():
        visited[last]+=1
    for e in edges:
        count = visited[e]
        if count and twice: continue
        if e == 'start': continue
        if e == 'end':
            paths += 1
            continue
        paths += search(C, e, visited, e if count else twice)
    if last.islower():
        visited[last]-=1
    return paths

paths=search(C, 'start', dd(int), None)
print(paths)
