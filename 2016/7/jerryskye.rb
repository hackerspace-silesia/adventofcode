def has_abba? str
	match = str.match(/(.)(.)\2\1/)
	match and match[1] != match[2]
end

def tls_capable? str
	ary = str.split(/[\[\]]/)
	outside_brackets = []
	in_brackets = []
	ary.each_index do |i|
		if i % 2 == 0
			outside_brackets << ary[i]
		else
			in_brackets << ary[i]
		end
	end
	outside_brackets.any? {|x| has_abba? x} and in_brackets.all? {|x| not has_abba? x}
end

def ssl_capable? str
	ary = str.split(/[\[\]]/)
	outside_brackets = []
	in_brackets = []
	ary.each_index do |i|
		if i % 2 == 0
			outside_brackets << ary[i]
		else
			in_brackets << ary[i]
		end
	end

	outside_brackets.any? do |str|
		ary = []
		str.length.times do |i|
			match = str[i, 3].match(/(.)(.)\1/)
			ary << match if match and match[1] != match[2]
		end
		in_brackets.any? do |kek|
			ary.any? {|match| kek.include?(match[2] + match[1] + match[2])}
		end
	end
end

puts "Part one: %d" % File.readlines("input7.txt").count {|line| tls_capable? line.chomp }
puts "Part two: %d" % File.readlines("input7.txt").count {|line| ssl_capable? line.chomp }
