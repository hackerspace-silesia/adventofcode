from collections import Counter
from itertools import chain


def load_data(path):
    with open(path, "r") as f:
        return f.read()


if __name__ == "__main__":
    raw_file_lines = load_data("./input2.txt")
    group_of_answers = raw_file_lines.split("\n\n")
    yes_counter = 0
    for raw_answers in group_of_answers:
        answer_per_person = raw_answers.split("\n")
        number_of_people_in_group = len(answer_per_person)
        splitted_letters = map(set, answer_per_person)
        cnt = Counter(chain.from_iterable(splitted_letters))
        for number_of_yes in cnt.values():
            if number_of_yes == number_of_people_in_group:
                yes_counter += 1
    print(yes_counter)
