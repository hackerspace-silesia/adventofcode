nice_count = 0
data = File.read("input5.txt")
data.each_line do |line|
	vowel_count = 0
	double_letter = false
	temp = ""
	next if line.match(/ab|cd|pq|xy/)
	line.each_char do |char|
		double_letter = true if temp == char
		vowel_count += 1 if char.match(/[aeiou]/)
		temp = char
	end
	nice_count += 1 if double_letter && vowel_count >= 3
end
puts nice_count
