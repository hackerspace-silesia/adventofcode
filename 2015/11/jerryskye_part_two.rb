input = "vzbxxyzz".next
def valid string
	straight = false
	ary = string.chars
	ary.each_index do |i|
		if ary[i + 2]
			straight = true if ary[i + 2] == ary[i + 1].next and ary[i].next == ary[i + 1]
		end
	end
	count = 0
	ary.uniq.each do |x|
		count += 1 if string.match(x * 2)
	end
	return (string.length == 8 and straight and string.match(/[iol]/) == nil and count >= 2)
end
until(valid(input))
	input.next!
end
p input
