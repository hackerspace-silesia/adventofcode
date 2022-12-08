import sys
from collections import defaultdict


def read():
    lines = sys.stdin.readlines()
    return [list(map(int, list(line.strip()))) for line in lines]


def mark_visible(data):
    visible = defaultdict(str)
    size = len(data)
    highest_top = [-1] * size
    highest_left = [-1] * size
    highest_right = [-1] * size
    highest_bottom = [-1] * size

    for i in range(size):
        for j in range(size):
            v = data[i][j]
            if v > highest_top[j]:
                highest_top[j] = v
                visible[(i, j)] += 'T'
            if v > highest_left[i]:
                highest_left[i] = v
                visible[(i, j)] += 'L'

    for i in range(size-1, -1, -1):
        for j in range(size-1, -1, -1):
            v = data[i][j]
            if v > highest_bottom[j]:
                highest_bottom[j] = v
                visible[(i, j)] += 'B'
            if v > highest_right[i]:
                highest_right[i] = v
                visible[(i, j)] += 'R'

    return visible


def view(data):
    best = 0
    size = len(data)
    for i in range(size):
        for j in range(size):
            scores = [0] * 4
            v = data[i][j]

            left = j - 1
            while left >= 0:
                scores[0] += 1
                if data[i][left] >= v:
                    break
                left -= 1
            right = j + 1
            while right < size:
                scores[1] += 1
                if data[i][right] >= v:
                    break
                right += 1
            top = i - 1
            while top >= 0:
                scores[2] += 1
                if data[top][j] >= v:
                    break
                top -= 1
            bottom = i + 1
            while bottom < size:
                scores[3] += 1
                if data[bottom][j] >= v:
                    break
                bottom += 1

            score = scores[0] * scores[1] * scores[2] * scores[3]
            print(scores)
            if score > best:
                best = score
    return best


if __name__ == '__main__':
    data = read()
    print(len(mark_visible(data)))
    print(view(data))
