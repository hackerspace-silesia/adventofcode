import pandas as pd


def get_input(file_name):
    with open(file_name) as file:
        return [list(line.rstrip()) for line in file.readlines()]


# def solve(file_name):
#     input = get_input(file_name)
#     df = pd.DataFrame(input)
#     most_common = []
#     least_common = []
#     for column in df.columns:
#         df[column] = df[column].astype(int)
#         value = round(df[column].sum() / df[column].count())
#         most_common.append(value)
#         value ^= 1
#         least_common.append(value)
#     return int(''.join(map(str, most_common)), 2)* int(''.join(map(str, least_common)), 2)

# print(solve("input_kg.txt"))


def get_value(df, column):
    df[column] = df[column].astype(int)
    oper = df[column].sum() / df[column].count()
    if oper == 0.5:
        value = 1
    else:
        value = round(oper)
    return value

def solve_2(file_name):
    input = get_input(file_name)
    df = pd.DataFrame(input)
    for column in df.columns:
        value = get_value(df, column)
        if df[column].count() == 1:
            break
        df = df[df[column] == value]

    oxygen = df.values.tolist()[0]
    df = pd.DataFrame(input)
    for column in df.columns:       
        value = get_value(df, column)
        if df[column].count() == 1:
            break
        df = df[df[column] != value]
    co2 = df.values.tolist()[0]
    return int(''.join(map(str, oxygen)), 2)*int(''.join(map(str, co2)), 2)

print(solve_2("input_kg.txt"))
