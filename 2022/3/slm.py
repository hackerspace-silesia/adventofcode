import sys


def read():
    return [l for  l in sys.stdin.read().split('\n') if l.strip()]


def to_priority(letter):
    if letter.islower():
        return ord(letter) - ord('a') + 1
    return ord(letter) - ord('A') + 27


def commons(data):
    for l in data:
        i1, i2 = l[:len(l)//2], l[len(l)//2:]
        common = set(i1) & set(i2)
        yield common.pop()


def commons2(l):
    for i in range(0, len(l), 3):
        yield (set(l[i]) & set(l[i+1]) & set(l[i+2])).pop()


if __name__ == '__main__':
    data = read()
    print(sum(to_priority(i) for i in commons(data)))
    print(sum(to_priority(i) for i in commons2(data)))
