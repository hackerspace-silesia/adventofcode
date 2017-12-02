data = File.read("input13b.txt")
hsh = Hash.new
data.each_line do |line|
	match = line.scan(/[A-Z]\w+/)
	unless hsh.has_key? match[0] and hsh[match[0]].is_a? Hash
		hsh[match[0]] = Hash.new
	end
	hsh[match[0]][match[1]] = if line.match(/lose/)
								  -((line.match(/\d+/)[0]).to_i)
							  else
								  (line.match(/\d+/)[0]).to_i
							  end
end
happiness = Array.new
hsh.keys.permutation(hsh.keys.length) do |x|
	count = 0
	x.each_index do |i|
		if x[i] == x.last
			count += hsh[x[i]][x[0]]
			count += hsh[x[0]][x[i]]
		else
			count += hsh[x[i]][x[i + 1]]
			count += hsh[x[i + 1]][x[i]]
		end
	end
	happiness.push count
end
max = 0
happiness.each {|x| max = x if x > max}
p max
