count = 0
ary = File.read("input12.txt").scan(/-?\d+/)
ary.each {|x| count += x.to_i}
puts count
