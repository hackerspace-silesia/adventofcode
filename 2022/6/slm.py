import sys


def read():
    return sys.stdin.readline()


def find(line, length):
    start = 0
    count = 1
    i = 1

    while i < len(line):
        candidate = line[start:start+count]
        if count == length:
            return i

        duplicate = candidate.find(line[i])
        if duplicate == -1:
            count += 1
        else:
            count = count - duplicate
            start = start + duplicate + 1
        i += 1


if __name__ == '__main__':
    line = read()
    print(find(line, 4))
    print(find(line, 14))
