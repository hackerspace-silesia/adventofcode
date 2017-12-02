towns = Array.new
distances = Hash.new
max = 0
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
	max = value if value > max
end
p max
