import sys


def sorted_bugs(data):
    sums = []
    bag = []
    for n in data + ['']:
        if not n:
            sums.append(sum(bag))
            bag = []
            continue
        bag.append(int(n))
    return sorted(sums)


if __name__ == '__main__':
    data = sys.stdin.read().split('\n')
    bags = sorted_bugs(data)
    print(bags[-1])
    print(sum(bags[-3:]))
