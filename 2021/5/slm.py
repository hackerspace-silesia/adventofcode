import sys
from collections import defaultdict

board = defaultdict(int)
for line in sys.stdin:
    line = line.strip()
    l,r = line.split(" -> ")
    x1,y1 = map(int, l.split(","))
    x2,y2 = map(int, r.split(","))

    # vertical
    if x1 == x2:
        if y2<y1:
            y1,y2 = y2,y1
        for i in range(y1,y2+1):
            board[(x1,i)]+=1

    # horizontal
    if y1 == y2:
        if x2<x1:
            x1,x2 = x2,x1
        for i in range(x1,x2+1):
            board[(i,y1)]+=1

    # diagonal
    if x1 != x2 and y1 != y2:
        if y2<y1:
            y1,y2 = y2,y1
            x1,x2 = x2,x1
        if x2>x1:
            step = 1
        else:
            step = -1
        for i in range(abs(x1-x2)+1):
            board[(x1+i*step,y1+i)]+=1




print(board)
counter=0
for cell in board.values():
    if cell > 1:
        counter+=1

print(counter)
