import sys
import os
input = []

numbers = list(map(int, sys.stdin.readline().split(',')))
sys.stdin.readline()

boards = []
results = []

board = []
result = []
for line in sys.stdin:
    if not line.strip():
        boards.append(board)
        results.append(result)
        board = []
        result=[]
        continue
    b = list(map(int,line.split()))
    board.append(b)
    result.append([0]*len(b))

def is_winner(marks, board):
    for i, l in enumerate(marks):
        if sum(l)==len(l):
            return board[i]

    for i in range(len(marks)):
        s = []
        r = []
        for j in range(len(marks)):
            s.append(marks[j][i])
            r.append(board[j][i])
        if sum(s)==len(marks):
            return r
    return []

winners = []
for nr in numbers:
    for i, board in enumerate(boards):
        if i in winners: continue
        for j, line in enumerate(board):
            for k, v in enumerate(line):
                if v == nr:
                    results[i][j][k]=1
                    boards[i][j][k]=0
        res = is_winner(results[i], board)
        if len(res)>0:
            winners.append(i)
            print(i, (sum(map(sum,board))) * nr)
