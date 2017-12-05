input = STDIN.readlines.map(&:to_i)
def solve input, part
  current = 0
  steps = 0
  loop do
    instruction = input[current]
    break if instruction.nil?
    if instruction >= 3 and part == :part_two
      input[current] -= 1
    else
      input[current] += 1
    end
    current += instruction
    steps += 1
  end
  puts steps
end

solve input.dup, :part_one
solve input.dup, :part_two
