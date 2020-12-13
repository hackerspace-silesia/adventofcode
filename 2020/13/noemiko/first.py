from typing import List
from typing import Iterable, Any, Iterator, List


def load_data(path):
    with open(path, "r") as f:
        return f.readlines()


def prepare_data(file_lines: List[str]) -> (int, Iterator):
    user_departure_timestamp, buses = file_lines
    available_buses_lines = buses.replace("x,", "")
    list_of_buses_lines = available_buses_lines.split(",")
    return int(user_departure_timestamp), map(int, list_of_buses_lines)


def get_multiple_higher_than_timestamp(bus_line, user_deprature_timestamp):
    """
    Number of buse line indicate how often it departs
    the bus with ID 5 departs from the sea port at timestamps 0, 5, 10, 15, and so on.
    The bus with ID 11 departs at 0, 11, 22, 33, and so on
    """
    multiply = 0
    while multiply < user_deprature_timestamp:
        multiply += bus_line
    return multiply


def get_earlier_departure_bus(available_buses_lines: Iterator[int], user_departure_timestamp: int):
    earliest_buses_departures = []
    for bus_number in available_buses_lines:
        earliest_departure = get_multiple_higher_than_timestamp(bus_number, user_departure_timestamp)
        earliest_buses_departures.append((bus_number, earliest_departure))
    return min(earliest_buses_departures, key=lambda t: t[1])


if __name__ == "__main__":
    raw_instructions = load_data("./input1.txt")
    user_departure_timestamp, buses_lines = prepare_data(raw_instructions)
    earliest_bus = get_earlier_departure_bus(buses_lines, user_departure_timestamp)

    earlies_bus_line, earliest_departure = earliest_bus
    time_waiting_for_bus = earliest_departure - user_departure_timestamp
    print(time_waiting_for_bus * earlies_bus_line)
