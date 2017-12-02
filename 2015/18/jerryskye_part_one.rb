def neighbours i, j
	[[i - 1, j - 1], [i - 1, j], [i - 1, j + 1], [i, j - 1], [i, j + 1], [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]].keep_if {|x| (0..99).include?(x[0]) and (0..99).include?(x[1])}
end
def next_move array
	temp = Array.new(100) {Array.new}
	array.each_index do |i|
		array[i].each_index do |j|
			count = 0
			neighbours(i, j).each do |x|
				count += 1 if array[x[0]][x[1]]
			end
			if array[i][j]
				temp[i][j] = (count == 2 or count == 3)
			else
				temp[i][j] = count == 3
			end
		end
	end
	return temp
end
ary = Array.new
data = File.readlines("input18.txt")
data.each_index do |i|
	ary[i] = Array.new
	j = 0
	data[i].chomp.each_char do |char|
		ary[i][j] = (char == "#")
		j += 1
	end
end
100.times do
	ary = next_move(ary)
end
c = 0
ary.each do |x|
	x.each do |y|
		c += 1 if y
	end
end
p c
