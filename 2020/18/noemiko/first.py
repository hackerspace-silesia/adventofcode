from operator import add, sub, mul, truediv
from typing import List

LAST_INDEX = -1
LEFT_PARENTHESIS = "("
RIGHT_PARENTHESIS = ")"
OPERATORS = {
    '+': add,
    '-': sub,
    '*': mul,
    '/': truediv
}


def load_data(path):
    with open(path, "r") as f:
        for line in f.readlines():
            yield line.replace(" ", "").replace("\n", "")


def parse_to_rpn(formula: str) -> List[str]:
    """Parse to reversed polish notation"""
    notation = []
    temp_stack = []
    for char in formula:
        if char.isdigit():
            notation.append(char)
        elif char is LEFT_PARENTHESIS:
            temp_stack.append(char)
        elif char is RIGHT_PARENTHESIS:
            # when parenthesis is closed whe can add operation to notation
            if temp_stack and temp_stack[LAST_INDEX] is not LEFT_PARENTHESIS:
                operation = temp_stack.pop()
                notation.append(operation)
            temp_stack.pop()  # remove left parenthesis
        elif char in OPERATORS.keys():
            if temp_stack and temp_stack[LAST_INDEX] is not LEFT_PARENTHESIS:
                # append to notation previous operations
                operation = temp_stack.pop()
                notation.append(operation)
            # add current operation to stack
            temp_stack.append(char)
    # add left over operations
    notation.extend(temp_stack)
    return notation


def evaluate(expression: List[str]) -> int:
    """
    Evaluate RPN expression
    """
    stack = []
    for token in expression:
        if token.isdigit():
            stack.append(int(token))
        elif token in OPERATORS.keys():
            operation = OPERATORS[token]
            b = stack.pop()
            a = stack.pop()
            # first popped value should be second in operation
            result = operation(a, b)
            stack.append(result)
    return stack[0]


if __name__ == "__main__":
    formulas = load_data("./input1.txt")
    sum = 0
    for formula in formulas:
        rpn = parse_to_rpn(formula)
        result = evaluate(rpn)
        sum += result
    print(sum)
