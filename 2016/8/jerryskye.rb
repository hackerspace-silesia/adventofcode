class Display
	def initialize
		@matrix = Array.new(6) {Array.new(50, false)}
	end

	def feed line_of_code
		case
		when line_of_code.start_with?('rect')
			rect line_of_code.scan(/\d+/)
		when line_of_code.start_with?('rotate')
			rotate line_of_code
		else
			puts "Invalid line."
		end
	end

	def count_lit_pixels
		@matrix.flatten.count {|pixel| pixel}
	end

	def print
		@matrix.each do |line|
			puts line.map {|x| x ? "*" : " "}.join
		end
	end

	private
	def rect ary
		ary[1].to_i.times do |r|
			ary[0].to_i.times do |c|
				@matrix[r][c] = true
			end
		end
	end

	def rotate loc
		nums = loc.scan(/\d+/)
		case
		when loc.include?("row")
			nums[1].to_i.times do
				@matrix[nums[0].to_i].insert(0, @matrix[nums[0].to_i].pop)
			end
		when loc.include?("column")
			col = @matrix.map {|ary| ary[nums[0].to_i]}
			nums[1].to_i.times do
				col.insert(0, col.pop)
			end
			@matrix.each_index do |i|
				@matrix[i][nums[0].to_i] = col[i]
			end
		end
	end
end

display = Display.new
File.readlines("input8.txt").each {|line| display.feed line}
puts display.count_lit_pixels
display.print
