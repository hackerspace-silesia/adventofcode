def count_number_of_rows_where_no_duplicated_words(path):
    try:
        with open(path, 'r') as file:
            passphrases = file.read().split('\n')
            list_of_words = [word.split() for word in passphrases]
            counter_valid = 0
            for word in list_of_words:
                if len(set(word)) == len(word):
                    counter_valid += 1
    except FileNotFoundError as err:
        exit(err)
    return counter_valid


def count_number_of_rows_where_not_words_with_the_same_letters(path):
    try:
        with open(path, 'r') as file:
            passphrases = file.read().split('\n')
            list_of_words = [word.split() for word in passphrases]
            counter_valid = 0
            for words in list_of_words:
                prepared_words = []
                for word in words:
                    prepared_words.append(''.join(sorted(word)))
                if len(set(prepared_words)) == len(prepared_words):
                    counter_valid += 1
    except FileNotFoundError as err:
        exit(err)
    return counter_valid


if __name__ == "__main__":
    print("First solution:")
    print(count_number_of_rows_where_no_duplicated_words('./input.txt'))
    print("Second solution:")
    print(count_number_of_rows_where_not_words_with_the_same_letters('./input.txt'))
