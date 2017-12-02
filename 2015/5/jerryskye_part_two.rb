nice_count = 0
data = File.read("input5.txt")
data.each_line do |line|
	pair = false
	repeat = false
	i = 0
	line.each_char do |char|
		repeat = true if line.match(/#{char}\w#{char}/)
		pair = true if line.scan(line[i, 2]).size > 1
		i += 1
	end
	nice_count += 1 if pair && repeat
end
puts nice_count
