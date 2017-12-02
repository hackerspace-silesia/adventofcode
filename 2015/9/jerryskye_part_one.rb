towns = Array.new
distances = Hash.new
min = 9999999999
file = File.read("input9.txt")
file.each_line do |line|
	towns += line.scan(/[A-Z]\w+/)
	distances[line.scan(/[A-Z]\w+/)] = line.scan(/\d+/).first.to_i
	distances[line.scan(/[A-Z]\w+/).reverse] = line.scan(/\d+/).first.to_i
end
towns.uniq.permutation(towns.uniq.length) do |x|
	value = 0
	x.each_index do |i|
		if x[i + 1]
			value += distances[[x[i], x[i + 1]]]
		end
	end
	min = value if value < min
end
p min
