vectors = {"^" => [0, 1], "v" => [0, -1], ">" => [1, 0], "<" => [-1, 0]}
position = [0, 0]
ary = [position.join]
File.open("input3.txt") do |f|
	f.each_char do |char|
		if vectors.has_key?(char)
			position[0] += vectors[char][0]
			position[1] += vectors[char][1]
			ary.push(position.join) unless ary.include?(position.join)
		end
	end
end
puts ary.size
