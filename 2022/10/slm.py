import sys
from collections import defaultdict


def read():
    return [l.strip() for l in sys.stdin.readlines() if l.strip()]


def run(data):
    h = []
    x = 1
    for cmd in data:
        match cmd.split():
            case ["noop"]:
                h.append(x)
            case ["addx", v]:
                v = int(v)
                h.append(x)
                h.append(x)
                x += v
    h.append(x)
    return h


def part1(h):
    s = 0
    for i in [20, 60, 100, 140, 180, 220]:
        s += i * h[i-1]
    print(s)


def part2(h):
    for slice in range(0, 240, 40):
        line = ""
        for pixel, sprite in enumerate(h[slice:slice+40]):
            if (sprite - 1) <= pixel <= (sprite + 1):
                line += "#"
            else:
                line += "."
        print(line)


if __name__ == '__main__':
    data = read()
    h = run(data)
    part1(h)
    part2(h)
