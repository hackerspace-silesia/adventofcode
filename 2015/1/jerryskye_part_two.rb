hsh = {"(" => 1, ")" => -1}
output = 0
count = 0
File.open("input1.txt") do |f|
	f.each_char do |char|
		if char == "(" or char == ")"
			output += hsh[char]
			count += 1
		end
		if output < 0
			puts count
			break
		end
	end
end
