code_chars = real_chars = 0

File.readlines("input8.txt").each do |line|
	line.chomp!
	code_chars += line.length
	real_chars += eval(line).length
end

p code_chars - real_chars
