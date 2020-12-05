def load_data(path):
    with open(path, "r") as f:
        return f.readlines()


class Seat:
    def __init__(self, code):
        self.code = code

    def get_row(self):
        rows_indexes = [x for x in range(128)]
        for code in self.code[:7]:
            rows_indexes = get_half_rows_by_code(code, rows_indexes)
        return rows_indexes[0]

    def get_column(self) -> int:
        rows_indexes = [x for x in range(8)]
        for code in self.code[7:]:
            rows_indexes = get_half_columns_by_code(code, rows_indexes)
        return rows_indexes[0]


def get_half_rows_by_code(code, rows_indexes):
    if code == "F":
        return rows_indexes[:len(rows_indexes) // 2]
    elif code == "B":
        return rows_indexes[len(rows_indexes) // 2:]
    else:
        raise ValueError(f"UNKNOW CODE {code}")


def get_half_columns_by_code(code, rows_indexes):
    if code == "L":
        return rows_indexes[:len(rows_indexes) // 2]
    elif code == "R":
        return rows_indexes[len(rows_indexes) // 2:]
    else:
        raise ValueError(f"UNKNOW CODE {code}")


if __name__ == "__main__":
    raw_file_lines = load_data("./input1.txt")
    seats_ids = []
    for code in raw_file_lines:
        code = code.strip()
        seat = Seat(code)
        row_number = seat.get_row()
        column_number = seat.get_column()
        seat_id = row_number * 8 + column_number
        seats_ids.append(seat_id)
    print(max(seats_ids))
