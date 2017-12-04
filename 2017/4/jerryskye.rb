part_one = 0
part_two = 0
STDIN.read.each_line do |line|
  ary = line.split
  part_one += 1 if ary == ary.uniq
  ary.map! {|str| str.chars.sort.join }
  part_two += 1 if ary == ary.uniq
end

puts part_one
puts part_two
