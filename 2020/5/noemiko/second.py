from pprint import pprint


def load_data(path):
    with open(path, "r") as f:
        return f.readlines()


class PlaneSeats:
    def __init__(self, list_of_code_seats):
        self.seats = self.get_seats(list_of_code_seats)

    def get_seats(self, list_of_code_seats):
        seats = []
        for code in list_of_code_seats:
            code = code.strip()
            seat = Seat(code)
            seats.append(seat)
        return seats

    def get_plane_map(self):
        plane_map = [[0 for _ in range(8)] for _ in range(128)]
        for seat in self.seats:
            plane_map[seat.row_id][seat.column_id] = 1
        return plane_map


class Seat:
    def __init__(self, code):
        self.code = code
        self.column_id = self.get_column()
        self.row_id = self.get_row()

    def get_row(self):
        rows_indexes = [x for x in range(128)]
        for code in self.code[:7]:
            rows_indexes = get_half_rows_by_code(code, rows_indexes)
        return rows_indexes[0]

    def get_column(self) -> int:
        columns_indexes = [x for x in range(8)]
        for code in self.code[7:]:
            columns_indexes = get_half_columns_by_code(code, columns_indexes)
        return columns_indexes[0]


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
    raw_file_lines = load_data("./input2.txt")
    plane_seats = PlaneSeats(raw_file_lines)
    plane_map = plane_seats.get_plane_map()
    for index, row in enumerate(plane_map):
        empty_places = [x for x in row if x == 0]
        if len(empty_places) == 1:
            for index_y, x in enumerate(row):
                if x == 0:
                    pprint(index * 8 + index_y)
