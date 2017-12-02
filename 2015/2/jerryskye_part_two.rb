output = 0
File.open("input2.txt") do |f|
	f.each_line do |line|
		match = [line[/(\d+)x(\d+)x(\d+)/, 1].to_i, line[/(\d+)x(\d+)x(\d+)/, 2].to_i, line[/(\d+)x(\d+)x(\d+)/, 3].to_i].sort
		output += match[0] * match[1] * match[2] + 2 * (match[0] + match[1])
	end
end
puts output
