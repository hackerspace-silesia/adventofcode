import sys

SCORE_GAME = {
    'L': 0,
    'D': 3,
    'W': 6,
}

SCORE_CARD = {
    'R': 1,
    'P': 2,
    'S': 3,
}

MAPPING = {
    'X': 'R',
    'A': 'R',
    'B': 'P',
    'Y': 'P',
    'C': 'S',
    'Z': 'S',
    'R': 'R',
    'P': 'P',
    'S': 'S',
}


def solve(opponent, me):
    opponent = MAPPING[opponent]
    me = MAPPING[me]

    if opponent == 'R':
        if me == 'R':
            return 'D'
        elif me == 'P':
            return 'W'
        return 'L'
    elif opponent == 'P':
        if me == 'R':
            return 'L'
        elif me == 'P':
            return 'D'
        return 'W'
    else:  # opponent == 'S':
        if me == 'R':
            return 'W'
        elif me == 'P':
            return 'L'
        return 'D'


def convert(data):
    converted = []
    for game in data:
        me = ''
        opponent, result = game
        opponent = MAPPING[opponent]
        if result == 'X':  # lose
            if opponent == 'R':
                me = 'S'
            elif opponent == 'P':
                me = 'R'
            else:
                me = 'P'
        if result == 'Y':  # draw
            me = opponent
        if result == 'Z':  # win
            if opponent == 'R':
                me = 'P'
            elif opponent == 'P':
                me = 'S'
            else:
                me = 'R'
        converted.append([opponent, me])
    return converted


def read():
    return [l.split(" ") for l in sys.stdin.read().split('\n') if l]


def play(data):
    sum = 0
    for game in data:
        opponent, me = game
        result = solve(opponent, me)
        sum += SCORE_CARD[MAPPING[me]]
        sum += SCORE_GAME[result]
    return sum


if __name__ == '__main__':
    data = read()
    print(play(data))
    print(play(convert(data)))
