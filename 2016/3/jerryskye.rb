def is_triangle? ary
	ary.permutation(3).each do |perm|
		unless perm[0] + perm[1] > perm[2]
			return false
		end
	end
	return true
end

input = File.readlines("input3.txt")
puts(input.count do |line|
	sc = line.scan(/\d+/).map{|x| x.to_i}
	is_triangle? sc
end)

ary = Array.new(3) {Array.new}
input.each do |line|
	kek = line.scan(/\d+/)
	3.times do |i|
		ary[i].push(kek[i].to_i)
	end
end

count = 0

ary.flatten.each_slice(3) do |triplet|
	count += 1 if is_triangle? triplet
end

puts count
