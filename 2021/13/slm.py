import sys
from collections import defaultdict as dd
import itertools as it

def print_paper(D):
#    max_x= max(D.keys()) + 1
#    max_y = max(list(it.chain(*[i.keys() for i in D.values()]))) + 1
#
    max_x = 50
    max_y = 10

    for y in range(max_y):
        for x in range(max_x):
            v = D[x][y]
            if v:
                print("#", end="")
            else:
                print(".", end="")
        print()


D = dd(lambda: dd(bool))
for line in sys.stdin:
    line = line.strip()
    if not line: break

    x, y = line.split(",")
    D[int(x)][int(y)]=True

C = []
for line in sys.stdin:
    _, _, cmd = line.split()
    C.append(cmd.split("="))

def fold(D, fx=None, fy=None):
    if fx and fy: raise Exception("x and y cannot be set")
    if fy:
        move=[]
        for x, ys in D.items():
            for y in ys.keys():
                if not D[x][y]: continue
                if y > fy:
                    move.append((x,y))
        for m in move:
            x=m[0]
            y=m[1]
            D[x][y] = False
            D[x][fy-(y-fy)]=True

    if fx:
        move=[]
        for x, ys in D.items():
            for y in ys.keys():
                if not D[x][y]: continue
                if x > fx:
                    move.append((x,y))
        for m in move:
            x=m[0]
            y=m[1]
            D[x][y] = False
            D[fx-(x-fx)][y]=True

def count(D):
    c=0
    for x, ys in D.items():
        for y in ys.values():
            if y:
                c+=1
    return c

for c in C:
    var = c[0]
    val = int(c[1])
    if var == 'x':
        fold(D, fx=val)
    else:
        fold(D, fy=val)

print(count(D))
print_paper(D)
