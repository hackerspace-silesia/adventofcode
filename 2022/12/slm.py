import sys
from collections import deque


START = ord('S')
END = ord('z') + 1
INF = 1000000000


def read():
    return [[ord(i) if i != 'E' else ord('z') + 1 for i in list(l.strip())] for l in sys.stdin.readlines()]


def get(map, s):
    for j, row in enumerate(map):
        try:
            index = row.index(s)
        except Exception:
            continue
        return index, j


def neigbours(p, map):
    n = []
    pv = map[p[1]][p[0]]
    for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
        nx = p[0] + dx
        ny = p[1] + dy
        if 0 <= nx < len(map[0]) and 0 <= ny < len(map):
            nv = map[ny][nx]
            if nv in [pv + 1, pv] or pv == START or nv < pv:
                n.append((nx, ny))
    return n


def shortestPath(start, map):
    end = get(map, END)
    path = {start: 0}
    visited = {start: True}
    Q = deque()
    Q.append(start)
    while Q:
        v = Q.popleft()
        if v == end:
            break
        for n in neigbours(v, map):
            if visited.get(n, False):
                continue
            visited[n] = True
            path[n] = path[v] + 1
            Q.append(n)
    return path.get(end, INF)


def part1(map):
    start = get(map, START)
    print(shortestPath(start, map))


def part2(map):
    min = INF

    a = ord("a")
    for y in range(len(map)):
        for x in range(len(map[0])):
            p = (x, y)
            if map[y][x] != a:
                continue
            steps = shortestPath(p, map)
            if steps < min:
                min = steps
    print(min)


if __name__ == '__main__':
    data = read()
    part1(data)
    part2(data)
