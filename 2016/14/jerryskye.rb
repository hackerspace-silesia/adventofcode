require 'digest'
require 'ruby-progressbar'

class KeyCalculator
	attr_reader :keys, :index
	def initialize input
		@salt = input
		@keys = 0
		@index = 0
		@md5 = Digest::MD5.new
	end

	def stretch_hash h
		2016.times do
			h = @md5.hexdigest h
		end
		h
	end

	def is_a_key? str, i
		match = str.match(/(.)\1\1/)
		if match
			((i + 1)..(i + 1000)).any? do |i|
				kek = stretch_hash(@md5.hexdigest("%s%d" % [@salt, i]))
				kek.include?(match[1] * 5)
			end
		else
			false
		end
	end

	def find_next_key
		loop do
			str = stretch_hash(@md5.hexdigest("%s%d" % [@salt, @index]))
			if is_a_key? str, @index
				@keys += 1
				@index += 1
				break
			else
				@index += 1
			end
		end
	end
end

c = KeyCalculator.new "cuanljph"
progressbar = ProgressBar.create(:total => 64, :format => "%c/%C")
while c.keys < 64
	c.find_next_key
	progressbar.increment
end
puts c.index - 1
