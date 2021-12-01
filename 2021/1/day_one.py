def part_one(numbers):
    return len([elem for index, elem in enumerate(numbers) if int(elem) > int(numbers[index - 1])])


def part_two(numbers):
    return part_one(
        [int(number) + int(numbers[index + 1]) + int(numbers[index + 2]) for index, number in enumerate(numbers) if
         index < len(numbers) - 2])


with open('input_mg.txt') as f:
    data = f.read().split('\n')
    assert 1233 == part_one(data)
    assert 1275 == part_two(data)
