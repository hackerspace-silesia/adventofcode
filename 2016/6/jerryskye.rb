input = File.readlines("input6.txt").sort
hsh = Array.new(8) {Hash.new}
input.each do |line|
	counter = 0
	line.chop.each_char do |c|
		if hsh[counter].has_key? c
			hsh[counter][c] += 1
		else
			hsh[counter][c] = 1
		end
		counter += 1
	end
end

hsh.each {|h| print h.max_by {|k, v| v}[0]}
puts
hsh.each {|h| print h.min_by {|k, v| v}[0]}
puts
