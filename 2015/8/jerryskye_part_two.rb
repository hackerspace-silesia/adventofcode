code_chars = chars = 0

File.readlines("input8.txt").each do |line|
	line.chomp!
	code_chars += line.length
	chars += line.dump.length
end

p chars - code_chars
