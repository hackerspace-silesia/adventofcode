from itertools import permutations


def calculate_checksum_with_max_min(path):
    try:
        with open(path, 'r') as file:
            spreadsheet = file.read().split('\n')
            checksum = 0
            for i in spreadsheet:
                row = i.replace('\t', ',')
                row = row.split(',')
                row = list(map(int, row))
                checksum += max(row)-min(row)

    except FileNotFoundError as err:
        exit(err)
    return checksum


def calculate_checksum_with_divide(path):
    try:
        with open(path, 'r') as file:
            spreadsheet = file.read().split('\n')
            checksum = 0
            for i in spreadsheet:
                row = i.replace('\t', ',')
                row = row.split(',')
                row = list(map(int, row))
                for x, y in permutations(row, 2):
                    if x % y == 0:
                        checksum += x//y
    except FileNotFoundError as err:
        exit(err)
    return checksum


if __name__ == "__main__":
    print("First solution:")
    print(calculate_checksum_with_max_min('./input.txt'))
    print("Second solution:")
    print(calculate_checksum_with_divide('./input.txt'))