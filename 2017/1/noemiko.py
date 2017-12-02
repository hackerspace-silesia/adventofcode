def sum_digits_where_next_digit_is_the_same(path):
    try:
        with open(path, 'r') as file:
            digits = list(map(int, file.read()))
            summary = 0
            digits_len = len(digits)
            for index, digit in enumerate(digits):
                index_to_compare = (index+1) % digits_len
                if digit == digits[index_to_compare]:
                    summary+=digit
    except FileNotFoundError as err:
        exit(err)
    return summary


def sum_expected_digits(path):
    try:
        with open(path, 'r') as file:
            digits = list(map(int, file.read()))
            summary = 0
            digits_len = len(digits)
            steps_forward_to_compare = (digits_len//2)
            for index, digit in enumerate(digits):
                index_to_compare = (index+steps_forward_to_compare) % digits_len
                if digit == digits[index_to_compare]:
                    summary+=digit
    except FileNotFoundError as err:
        exit(err)
    return summary


if __name__ == "__main__":
    print("First solution:")
    print(sum_digits_where_next_digit_is_the_same('./input1.txt'))
    print("Second solution:")
    print(sum_expected_digits('./input2.txt'))