file = File.read("input6.txt")
ary = Array.new(1000) {Array.new(1000, false)}
file.each_line do |line|
	numbers = line.scan(/\d+/)
	numbers.each_index {|i| numbers[i] = numbers[i].to_i}
	if line.include?("turn on")
		for i in (numbers[0])..(numbers[2])
			for x in (numbers[1])..(numbers[3])
				ary[i][x] = true
			end
		end
		next
	end
	if line.include?("turn off")
		for i in (numbers[0])..(numbers[2])
			for x in (numbers[1])..(numbers[3])
				ary[i][x] = false
			end
		end
		next
	end
	if line.include?("toggle")
		for i in (numbers[0])..(numbers[2])
			for x in (numbers[1])..(numbers[3])
				ary[i][x] = !(ary[i][x])
			end
		end
		next
	end
end
counter = 0
ary.each_index do |i|
	ary[i].each {|x| counter += 1 if x}
end
p counter
