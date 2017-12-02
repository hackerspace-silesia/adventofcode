require 'pry'
input = "1113222113"
40.times do
	result = ""
	count = 0
	ary = input.chars
	ary.each_index do |i|
		count += 1
		unless ary[i + 1] == ary[i]
			result += count.to_s + ary[i]
			count = 0
		end
	end
	input = result
end
p input.length
pry
