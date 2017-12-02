def divsum num
	output = 0
	ary = (1..num).select {|n| num % n == 0}
	ary.each {|x| output += x}
	return output
end
input = 2900000
n = 600000
sum = 0
while sum < input
	n -= 1
	sum = divsum n
end
p n
