class Decompresser
	def initialize i, o
		@buffer = ""
		@input = i
		@output = o
		@counter = 1
	end

	def flush_buffer
		@output.write @buffer
		@buffer.clear
	end

	def close
		@input.close
		@output.close
	end

	def decompress
		until @input.eof
			char = @input.readchar
			@buffer << char
			case char
			when '('
				until @buffer[-1] == ')'
					@buffer << @input.readchar
					@counter += 1
				end
				nums = @buffer[-@counter, @counter].scan(/\d+/)
				@buffer[-@counter, @counter] = @input.read(nums[0].to_i) * nums[1].to_i
				flush_buffer
				@counter = 1
			end
		end
		flush_buffer
	end
end

class LazyDecompresser < Decompresser
	attr_reader :size
	def initialize i, o
		super i, o
		@size = 0
	end

	def flush_buffer
		@size += @buffer.size
		@buffer.clear
	end

	def decompress
	end
end

dec = Decompresser.new(File.open('input9.txt', 'r'), File.open('output9a.txt', 'w'))
dec.decompress
dec.close
puts File.size("output9a.txt")
