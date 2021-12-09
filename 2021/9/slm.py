import sys

C = []
for line in sys.stdin:
    C.append(list(map(int,line.strip())))

points = [(-1,0), (1,0), (0,-1), (0, 1)]
def is_low(C, p):
    x=p[0]
    y=p[1]
    val = C[x][y]
    for i,j in points:
        try:
            current = C[x+i][y+j]
        except:
            current = 100000
        if current <= val:
            return False
    return True


l=[]
s=0
for i in range(len(C)):
    for j in range(len(C[i])):
        if is_low(C, (i,j)):
            v=C[i][j]
            s+=1+v
            l.append((i,j))

print(s)

# part 2
visited={}
def count(C, start):
    sum = 1
    visited[start]=True
    x=start[0]
    y=start[1]
    for i,j in points:
        nX, nY = x+i, y+j
        if nX <0 or nY<0: continue
        if (nX,nY) in visited: continue
        try:
            v = C[nX][nY]
        except:
            v=9
        if v==9: continue
        sum+=count(C, (nX, nY))
    return sum


B=[]

for low in l:
    B.append(count(C,low))

import functools
print(functools.reduce(lambda x, y: x*y, sorted(B)[-3:]))
