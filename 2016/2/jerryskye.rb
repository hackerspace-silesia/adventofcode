require 'pry'

class Keypad
	def initialize
		@button = 5
		@combination = ""
	end

	def push_button
		@combination << @button.to_s
	end

	def move direction
		case direction
		when 'U'
			@button -= 3 unless @button <= 3
		when 'D'
			@button += 3 unless @button >= 7
		when 'L'
			@button -= 1 unless @button % 3 == 1
		when 'R'
			@button += 1 unless @button % 3 == 0
		end
	end
end

class WeirdLayout < Keypad
	@@keypad = [
		[nil, nil, nil, nil, nil, nil, nil],
		[nil, nil, nil, '1', nil, nil, nil],
		[nil, nil, '2', '3', '4', nil, nil],
		[nil, '5', '6', '7', '8', '9', nil],
		[nil, nil, 'A', 'B', 'C', nil, nil],
		[nil, nil, nil, 'D', nil, nil, nil],
		[nil, nil, nil, nil, nil, nil, nil]
	]

	def initialize
		@index = [3, 1]
		@combination = ""
	end

	def push_button
		@combination << @@keypad[@index[0]][@index[1]]
	end

	def move direction
		begin
		case direction
		when 'U'
			@index[0] -= 1 unless @@keypad[@index[0] - 1][@index[1]].nil?
		when 'D'
			@index[0] += 1 unless @@keypad[@index[0] + 1][@index[1]].nil?
		when 'L'
			@index[1] -= 1 unless @@keypad[@index[0]][@index[1] - 1].nil?
		when 'R'
			@index[1] += 1 unless @@keypad[@index[0]][@index[1] + 1].nil?
		end
		rescue => e
			binding.pry
		end
	end
end

keypad = WeirdLayout.new
File.readlines("input2.txt").each do |line|
	line.each_char {|c| keypad.move c }
	keypad.push_button
end

puts keypad.inspect
