def power_consumption(binary_numbers):
    storage = {}
    for binary in binary_numbers:
        for index, bit in enumerate(binary):

            if storage.get(index) is None:
                storage[index] = {
                    '0': 0,
                    '1': 0
                }

            if storage[index].get(bit, 0):
                storage[index][bit] += 1
            else:
                storage[index][bit] = 1

    most_commons = []
    less_commons = []
    for bits in storage.values():
        most_commons.append('0' if int(bits['0']) > int(bits['1']) else '1')
        less_commons.append('1' if int(bits['0']) > int(bits['1']) else '0')

    return int(''.join(most_commons), 2) * int(''.join(less_commons), 2)

def select_higher(zero, one):
    return '0' if zero > one else '1'

def select_lower(zero, one):
    return '0' if zero < one or zero == one else '1'

def oxygen_generator_rating(binary_numbers, index, strategy):

    if index > 999:
        raise Exception('Infinitive recursion Marcin!')

    if len(binary_numbers) == 1:
        return int(binary_numbers[0], 2)

    zero = 0
    one = 0
    for binary in binary_numbers:

        if binary[index] == '0':
            zero += 1
        if binary[index] == '1':
            one += 1

    return oxygen_generator_rating([number for number in binary_numbers if number[index] == strategy(zero, one)], index + 1, strategy)

with open('input.txt') as f:
    data = f.read().split('\n')
    assert 1131506 == power_consumption(data)
    assert 7863147 == oxygen_generator_rating(data, 0, select_lower) * oxygen_generator_rating(data, 0, select_higher)
