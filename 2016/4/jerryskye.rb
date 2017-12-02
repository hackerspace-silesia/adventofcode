def name_of line
	str = line[/\D+/].delete('-')
	str.chars.map do |char|
		kek = char
		line[/\d+/].to_i.times {kek = kek.next[0]}
		kek
	end.join
end

def hsh str
	result_hsh = {}
	str.each_char do |c|
		if result_hsh.has_key? c
			result_hsh[c] += 1
		else
			result_hsh[c] = 1
		end
	end
	return result_hsh
end

def compute_str hsh
	hsh.max(5) {|a, b| a[1] == b[1]? b[0] <=> a[0] : a[1] <=> b[1]}.map{|x| x[0].to_s}.join
end

counter = 0
input = File.readlines('input4.txt')
input.each do |line|
	counter += line[/\d+/].to_i if compute_str(hsh(line[/\D+/].delete('-'))) == line[/\w+\]/].chop
end
puts counter

# Part Two
input.map do |line|
	if name_of(line)[/north/i]
		throw line[/\d+/]
	end
end
