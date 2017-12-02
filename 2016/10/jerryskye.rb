$bots = []

class Bot
	def initialize val=nil
		@queue = []
		@values = [val]
	end

	def push_to_queue instruction
		@queue.push instruction
	end

	def give ary
		if ary[0].include? 'bot'
			begin
				$bots[ary[0].to_i].receive(@queue.delete(@queue.min))
			rescue => e
				puts e
				puts ary[1]
				Kernel.exit
			end
		end

		if ary[1].include? 'bot'
			begin
				$bots[ary[1].to_i].receive(@queue.delete(@queue.max))
			rescue => e
				e
				puts ary[1]
				Kernel.exit
			end
		end
	end

	def receive chip
		@values.push(chip)
		case @values
		when @values.length > 2
			raise "More than 2 chips."
		when [61, 17], [17, 61]
			raise "This is it!"
		end
		run
	end

	def run
		return nil if @values.length < 2
		until @queue.empty?
			numbers = @queue.shift.scan(/to \w+ \d+/)
			give numbers
		end
	end
end

File.readlines("input10.txt").sort.reverse_each do |line|
	sc = line.scan(/\d+/)
	if line.start_with? 'value'
		$bots[sc.last.to_i] = Bot.new(sc.first.to_i)
	else
		$bots[sc.first.to_i] = Bot.new unless $bots[sc.first.to_i]
		$bots[sc.first.to_i].push_to_queue(line.split(" gives ")[1].to_i)
	end
end
