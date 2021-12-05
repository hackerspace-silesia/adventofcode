import pandas as pd

def get_input(input_file):
    boards = []
    game_numbers = []
    with open(input_file) as file:
        game_numbers = file.readline().strip().split(",")
        file.readline()
        board = []
        for line in file:
            if line.rstrip() == "":
                boards.append(board)
                board = []
            else:
                board.append(line.strip().split())

    return game_numbers, boards


def check_df(df, board_size, numbers):
    for column in df.columns:
        results = df[df[column].isin(numbers)]
        if len(results)==board_size:
            return calculate_sum(df, numbers)


def check_board(df, board_size, numbers):
    column_result = check_df(df, board_size, numbers) 
    row_result = check_df(df.transpose(), board_size, numbers)
    if column_result:
        return column_result
    elif row_result:
        return row_result


def calculate_sum(df, numbers):
    return sum(df[column].loc[~df[column].isin(numbers)].astype(int).sum() for column in df.columns)


def play_bingo():
    game_numbers, boards = get_input("input_kg.txt")
    ongoing_game_numbers = []
    order_won = []
    for number in game_numbers:
        ongoing_game_numbers.append(number)
        for idx, board in enumerate(boards):
            df = pd.DataFrame(board)
            bingo_size = len(df)
            result = check_board(df, bingo_size, ongoing_game_numbers)
            if result and idx not in order_won:
                order_won.append(idx)
                final_win = result*int(ongoing_game_numbers[-1])
    return final_win

print(play_bingo())