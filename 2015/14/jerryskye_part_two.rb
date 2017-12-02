require 'pry'
class Reindeer
	def initialize speed, flying_time, rest_time
		@speed = speed
		@flying_time = flying_time
		@rest_time = rest_time
		@points = 0
		@distance = 0
		@timer = [flying_time, :flying]
	end

	def award
		@points += 1
	end

	def fly
		if @timer[0] == 0 and @timer[1] == :flying
			@timer[0] = @rest_time
			@timer[1] = :resting
		end
		if @timer[0] == 0 and @timer[1] == :resting
			@timer[0] = @flying_time
			@timer[1] = :flying
		end
		@distance += @speed if @timer[1] == :flying
		@timer[0] -= 1
	end

	def distance
		@distance
	end

	def points
		@points
	end
end

ary = Array.new
data = File.read("input14.txt")
i = 0
data.each_line do |line|
	match = line.scan(/\d+/)
	ary[i] = Reindeer.new(match[0].to_i, match[1].to_i, match[2].to_i)
	i += 1
end
for i in 0...2503
	ary.each {|x| x.fly}
	ary.sort! {|a, b| a.distance <=> b.distance}
	ary.each {|x| x.award if x.distance == ary.last.distance}
	i += 1
end
pry
