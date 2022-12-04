import sys


def read():
    data = []
    for line in sys.stdin.read().split('\n'):
        line = line.strip()
        if not line:
            continue
        sections = line.split(',')
        data.append([list(map(int, sections[0].split('-'))), list(map(int, sections[1].split('-')))])
    return data


def includes(data):
    i = 0
    for l in data:
        s1, e1 = l[0]
        s2, e2 = l[1]
        if s1 <= s2 and e1 >= e2:
            i += 1
        elif s2 <= s1 and e2 >= e1:
            i += 1
    return i


def overlap(data):
    i = 0
    for l in data:
        s1, e1 = l[0]
        s2, e2 = l[1]
        if e1 - s1 + e2 - s2 >= max(e1, e2) - min(s1, s2):
            i += 1
    return i


if __name__ == '__main__':
    data = read()
    print(includes(data))
    print(overlap(data))
