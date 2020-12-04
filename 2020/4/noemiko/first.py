from dataclasses import dataclass
from typing import Optional, Dict, List


@dataclass
class Passport:
    ecl: str
    pid: str
    eyr: str
    hcl: str
    byr: str
    iyr: str
    hgt: str
    cid: Optional[str] = None

    @classmethod
    def is_valid(cls, fields):
        print(fields)
        try:
            cls(**fields)
        except TypeError as e:
            print(e)
            return False
        return True


def serialize_to_dict(passport: str) -> Dict:
    """
    Serialize string representation fo passport to dict
    :param passport: string representation of passport fields
    e.g. eyr:2021 iyr:2015 ecl:oth hgt:162cm pid:137342936 byr:1922 hcl:#888785
    :return:
    {'eyr': '2021', 'iyr': '2015', 'ecl': 'oth', 'hgt': '162cm', 'pid': '137342936', 'byr': '1922', 'hcl': '#888785'}
    """
    fields = passport.split(" ")
    passp = {}
    for field in fields:
        field = field.replace("\n", "")
        key, value = field.split(":")
        passp.update({key: value})
    return passp


def complete_all_passports(raw_lines: List[str]):
    """
    :param raw_lines: every list is representation of file line,
    every passport is separated by empty line
    :return:
    """
    complete_passports = []
    buffor = []
    for file_line in raw_lines:
        if file_line == "\n":
            complete_passports.append(buffor)
            buffor = []
            continue
        buffor.append(file_line)
    complete_passports.append(buffor)
    return complete_passports


def load_data(path):
    with open(path, "r") as f:
        return f.readlines()


if __name__ == "__main__":
    raw_file_lines = load_data("./input1.txt")
    complete_passports = complete_all_passports(raw_file_lines)
    valid_passports = 0
    for passport_data in complete_passports:
        passport_as_str = ' '.join([str(elem) for elem in passport_data])
        passp_as_dict = serialize_to_dict(passport_as_str)
        is_valid = Passport.is_valid(passp_as_dict)
        if is_valid:
            valid_passports += 1
    print(valid_passports)
