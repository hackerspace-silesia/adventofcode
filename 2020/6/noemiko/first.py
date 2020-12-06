def load_data(path):
    with open(path, "r") as f:
        return f.read()


if __name__ == "__main__":
    raw_file_lines = load_data("./input1.txt")
    group_of_answers = raw_file_lines.split("\n\n")
    yes_counter = 0
    for raw_answer in group_of_answers:
        answers = raw_answer.replace("\n", "")
        deduped_answers = "".join(set(answers))
        yes_counter += len(deduped_answers)
    print(yes_counter)
