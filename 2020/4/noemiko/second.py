from typing import Optional, Dict, List
from re import match


class Passport:
    def __init__(self, ecl, pid, eyr, hcl, byr, iyr, hgt, cid=None):
        self.ecl = ecl
        self.pid = pid
        self.eyr = eyr
        self.hcl = hcl
        self.byr = byr
        self.iyr = iyr
        self.hgt = hgt
        self.cid = cid

    @property
    def byr(self):
        return self._byr

    @property
    def pid(self):
        return self._pid

    @property
    def eyr(self):
        return self._eyr

    @property
    def hcl(self):
        return self._hcl

    @property
    def ecl(self):
        return self._ecl

    @property
    def iyr(self):
        return self._iyr

    @property
    def hgt(self):
        return self._hgt

    @classmethod
    def is_valid(cls, fields):
        print(fields)
        try:
            cls(**fields)
        except (TypeError, ValueError) as e:
            print(e)
            return False
        return True

    @byr.setter
    def byr(self, value):
        if not 1920 <= int(value) <= 2002:
            raise ValueError(f"Invalid year value{value}")
        self._byr = value

    @ecl.setter
    def ecl(self, value):
        if value not in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
            raise ValueError(f"Invalid value  {value}")
        self._ecl = value

    @pid.setter
    def pid(self, value):
        if len(value) != 9:
            raise ValueError("wrong length")
        if match(r"^[0-9]$", value):
            raise ValueError(f"Invalid value  {value}")
        self._pid = value

    @eyr.setter
    def eyr(self, value):
        if not 2020 <= int(value) <= 2030:
            raise ValueError(f"Invalid value  {value}")
        self._eyr = value

    @hcl.setter
    def hcl(self, value: str):
        if len(value[1:])!=6:
            raise ValueError()
        if not match(r"^#[a-f0-9]{6}$", value):
            raise ValueError(f"Invalid value{value}")
        self._hcl = value

    @iyr.setter
    def iyr(self, value):
        if not 2010 <= int(value) <= 2020:
            raise ValueError(f"Invalid value of iyr field {value}")
        self._iyr = value

    @hgt.setter
    def hgt(self, value):
        if "cm" in value[-2:] and 150 <= int(value[:-2]) <= 193:
            pass
        elif "in" in value[-2:] and 59 <= int(value[:-2]) <= 76:
            pass
        else:
            raise ValueError(f"Invalid value  {value}")
        self._hgt = value


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
    raw_file_lines = load_data("./input2.txt")
    complete_passports = complete_all_passports(raw_file_lines)
    valid_passports = 0
    for passport_data in complete_passports:
        passport_as_str = ' '.join([str(elem) for elem in passport_data])
        passp_as_dict = serialize_to_dict(passport_as_str)
        is_valid = Passport.is_valid(passp_as_dict)
        if is_valid:
            valid_passports += 1
    print(valid_passports)
