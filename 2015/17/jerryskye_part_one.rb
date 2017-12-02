data = File.readlines("input17.txt")
data.each_index {|i| data[i] = data[i].to_i}
ary = Array.new
data.combination(9) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(8) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(7) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(6) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(5) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(4) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
data.combination(3) do |c|
	sum = 0
	c.each {|x| sum += x}
	ary.push c if sum == 150
end
p ary.count
