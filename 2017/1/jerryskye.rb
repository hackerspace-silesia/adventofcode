input = File.read('input1')
input_circular_list = input.chars.cycle
part_one = input_circular_list.take(input.size + 1)
half_input_size = input.size / 2
part_two = input_circular_list.take(input.size + half_input_size)
puts((0..input.size).reduce(0) do |memo, i|
  if part_one[i] == part_one[i + 1]
    memo + part_one[i].to_i
  else
    memo
  end
end)

puts((0..input.size).reduce(0) do |memo, i|
  if part_two[i] == part_two[i + half_input_size]
    memo + part_two[i].to_i
  else
    memo
  end
end)
