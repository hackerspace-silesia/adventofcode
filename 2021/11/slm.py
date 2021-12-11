import sys

import numpy as np

C = []
for line in sys.stdin:
    C.append(list(map(int,line.strip())))

C = np.array(C)

def neighbors(C, x, y):
    ng = []
    for i in [-1, 0, 1]:
        for j in [-1, 0, 1]:
            nx=x+i
            ny=y+j
            if nx>=0 and nx<len(C) and ny>=0 and ny<len(C):
                ng.append((nx,ny))
    return ng

F = 0
step_all = -1
step = 1
while True:
    C += 1
    flashed = {}
    step_flashes = 0
    while True:
        result = np.where(C>9)
        ids = [i for i in zip(*result) if i not in flashed]
        if not ids: break

        for ind in ids:
            step_flashes += 1
            flashed[ind] = True
            for n in neighbors(C, *ind):
                C[n] += 1
    for i in flashed:
        C[i] = 0

    # part 1
    if step < 100:
        F+=step_flashes

    # part 2
    if step_flashes == 100:
        step_all = step
        break
    step += 1

print(F)
print(step_all)

