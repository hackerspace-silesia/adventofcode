import sys
from collections import defaultdict


class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.visited = defaultdict(bool)
        self.visited[str(self)] = True

    def dist(self, p):
        return self.x - p.x, self.y - p.y

    def __repr__(self):
        return f'{self.x},{self.y}'

    def move(self, dx, dy):
        self.x += dx
        self.y += dy
        self.visited[str(self)] = True

    def update(self, head):
        x, y = head.dist(self)
        ax, ay = abs(x), abs(y)
        if ax <= 1 and ay <= 1:
            return
        if x == 0:
            self.y += sign(y) * 1
        elif y == 0:
            self.x += sign(x) * 1
        elif ax == 2 or ay == 2:
            self.y += sign(y) * 1
            self.x += sign(x) * 1
        self.visited[str(self)] = True


def read():
    lines = sys.stdin.readlines()
    data = []
    for line in lines:
        d, v = line.split()
        data.append((d, int(v)))
    return data


def sign(v):
    if v >= 0:
        return 1
    return -1


def move(data, l):
    snake = [Point(0, 0) for i in range(l)]
    head = snake[0]

    for cmd in data:
        dir, count = cmd
        for _ in range(count):
            if dir == 'U':
                head.move(0, 1)
            elif dir == 'D':
                head.move(0, -1)
            elif dir == 'R':
                head.move(1, 0)
            elif dir == 'L':
                head.move(-1, 0)

            prev = head
            for p in snake[1:]:
                p.update(prev)
                prev = p
    return snake


if __name__ == '__main__':
    data = read()
    s = move(data, 2)
    print(len(s[-1].visited))
    s = move(data, 10)
    print(len(s[-1].visited))
