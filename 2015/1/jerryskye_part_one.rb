hsh = {"(" => 1, ")" => -1}
output = 0
File.open("input1.txt") do |f|
	f.each_char do |char|
		output += hsh[char] if char == "(" or char == ")"
	end
end
puts output
