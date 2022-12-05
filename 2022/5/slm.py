import sys
from copy import deepcopy
from collections import defaultdict


def read():
    start = 1
    step = 4
    data = defaultdict(list)
    actions = []

    while True:
        line = sys.stdin.readline()
        if line.startswith(" 1"):
            break

        clean = line[start::step]
        for i, v in enumerate(clean):
            if v.strip():
                data[i].insert(0, v)

    sys.stdin.readline()
    for line in sys.stdin.readlines():
        if not line:
            continue
        actions.append(list(map(int, line.split(" ")[1::2])))

    return data, actions


def move(data, actions):
    for action in actions:
        amount, from_, to = action
        from_ -= 1
        to -= 1
        for i in range(amount):
            v = data[from_].pop()
            data[to].append(v)
    return data


def move2(data, actions):
    for action in actions:
        amount, from_, to = action
        from_ -= 1
        to -= 1
        v = data[from_][-amount:]
        data[from_] = data[from_][:-amount]
        data[to].extend(v)
    return data


if __name__ == '__main__':
    data, actions = read()
    part1 = move(deepcopy(data), actions)
    print(''.join(part1[i][-1] for i in range(len(part1))))

    part2 = move2(deepcopy(data), actions)
    print(''.join(part2[i][-1] for i in range(len(part2)) if part2[i]))
