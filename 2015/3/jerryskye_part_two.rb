vectors = {"^" => [0, 1], "v" => [0, -1], ">" => [1, 0], "<" => [-1, 0]}
santapos = [0, 0]
robopos = [0, 0]
ary = ["0:0"]
counter = 0
data = File.read("input3.txt")
data.each_char do |char|
if vectors.has_key?(char)
		if(counter  == 0)
			santapos[0] += vectors[char][0]
			santapos[1] += vectors[char][1]
			ary.push(santapos.join(":"))
		else
			robopos[0] += vectors[char][0]
			robopos[1] += vectors[char][1]
			ary.push(robopos.join(":"))
		end
		counter = counter == 0? 1 : 0
	end
end
puts ary.uniq.size
