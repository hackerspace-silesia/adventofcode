def bingo string
	hsh = {"children:" => 3, "cats:" => 7, "samoyeds:" => 2, "pomeranians:" => 3, "akitas:" => 0,
		"vizslas:" => 0, "goldfish:" => 5, "trees:" => 3, "cars:" => 2, "perfumes:" => 1}
	hsh.each_key do |key|
		if temp = (string.split.index(key))
			case key
			when "cats:", "trees:" then
				unless string.split[temp + 1].to_i > hsh[key]
					return false
				end
			when "pomeranians:", "goldfish:" then
				unless string.split[temp + 1].to_i < hsh[key]
					return false
				end
			else
				unless string.split[temp + 1].to_i == hsh[key]
					return false
				end
			end
		end
	end
	return true
end
data = File.readlines("input16.txt")
data.keep_if {|line| bingo(line)}
p data
