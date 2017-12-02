class TaxiCab
	def initialize
		@ary = []
		@position = [0, 0]
		@facing = 0
	end

	def go str
		num = str[/\d+/].to_i
		@facing += case str[0]
							 when "R"
								 1
							 when "L"
								 -1
							 else
								 raise "wrong direction"
							 end

		num.times do
			case @facing % 4
			when 0
				@position[1] += 1
			when 1
				@position[0] += 1
			when 2
				@position[1] -= 1
			when 3
				@position[0] -= 1
			else
				raise "wrong @facing"
			end
			throw @position if @ary.include?(@position)
			@ary.push @position.dup
		end
	end

	def blocks
		@position.reduce { |memo, obj| memo + obj.abs }
	end
end
