require 'pry'
data = File.readlines("input19.txt")
str = data.last.chomp
hsh = Hash.new
data[0...43].each do |line|
	match = line.scan(/\w+/)
	unless hsh.has_key?(match[0])
		hsh[match[0]] = Array.new
	end
	hsh[match[0]].push(match[1])
end
pry
