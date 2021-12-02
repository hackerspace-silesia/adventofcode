import re


def calculate_position(data):
    moves = { 'forward': 0, 'up': 0,'down': 0 }
    for dict_move in moves.items():
        compiled = re.compile(f'{dict_move[0]}\s\d')
        for move in re.findall(compiled, ','.join(data)):
            moves[dict_move[0]] += int(re.sub(r'\w+', '', move, 1))

    return int(moves['forward']) * (int(moves['down']) - int(moves['up']))


def calculate_position_aim(data):
    forward = 0
    aim = 0
    depth = 0

    for move in data:
        parsed_move = (re.match('(?P<name>[a-z]+)\s+(?P<value>\d)', move)).groupdict()
        name = parsed_move.get('name')
        value = int(parsed_move.get('value'))

        if name == 'forward':
            forward += value
            depth += value * aim
        if name == 'up':
            aim -= value
        if name == 'down':
            aim += value

    return forward * depth

with open('input_mg.txt') as f:
    data = f.read().split('\n')
    assert 1989265 == calculate_position(data)
    assert 2089174012 == calculate_position_aim(data)