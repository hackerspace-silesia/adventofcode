import sys
from typing import List


def part1(lines: List[str]):
    sum = 0
    for line in lines:
        if not line.strip(): continue
        numbers = []
        for l in line:
            if l.isdigit():
                numbers.append(l)
        if numbers:
            sum += int(numbers[0]+numbers[-1])
    return sum

def part2(lines: List[str])->int:
    m = {"one": "1",
         "two": "2",
         "three": "3",
         "four": "4",
         "five": "5",
         "six": "6",
         "seven": "7",
         "eight": "8",
         "nine": "9",
     }
    sum = 0
    for line in lines:
        if not line.strip(): continue
        new = []
        
        ind = 0
        while ind < len(line):
            if line[ind].isdigit():
                new.append(line[ind])
            else:
                for k, v in m.items():
                    if line[ind:].startswith(k):
                        new.append(v)
                        break
            ind += 1
        sum += int(new[0] + new[-1])
    return sum


if __name__ == '__main__':
    data = sys.stdin.read().split('\n')
    print(part1(data))
    print(part2(data))
