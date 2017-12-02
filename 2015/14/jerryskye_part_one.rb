data = File.read("input14.txt")
ary = Array.new
data.each_line do |line|
	match = line.scan(/\d+/)
	match.each_index {|i| match[i] = match[i].to_i}
	i = 0
	count = 0
	while(i < 2503)
		count += (2503 - i < match[1])? match[0] * (2503 - i) : match[0] * match[1]
		i += match[1] + match[2]
	end
	ary.push count
end
p ary
