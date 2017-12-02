data = File.readlines("input7.txt")
$machine = {}
$output = {}

data.each do |c|
	x,y = c.chomp.split('->')
	y = y.lstrip
	$machine[y] = x.split
end

def foo(gate)
	if gate.match(/^\d+$/)
		return gate.to_i
	end

    if ! $output.has_key?(gate)
		operate = $machine[gate]
		if operate.length == 1
			value = foo(operate[0])
		else
			z = operate[-2]
			if z == 'RSHIFT'
				value = foo(operate[0]) >> foo(operate[2])
			elsif z == 'LSHIFT'
				value = foo(operate[0]) << foo(operate[2])
			elsif z == 'AND'
				value = foo(operate[0]) & foo(operate[2])
			elsif z == 'OR'
				value = foo(operate[0]) | foo(operate[2])
			elsif z == 'NOT'
				value = ~foo(operate[1])
			end
		end
		$output[gate] = value
	end
	return $output[gate]
end

p foo('a')
