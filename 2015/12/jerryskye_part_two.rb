require 'json'
$output = 0

def count(array)
	if array.is_a? Array
		array.each do |x|
			count x if (x.is_a? Array or x.is_a? Hash)
			$output += x if x.is_a? Integer
		end
	end
	if array.is_a? Hash
		unless array.has_value? "red"
			array.each_value do |x|
				count x if (x.is_a? Array or x.is_a? Hash)
				$output += x if x.is_a? Integer
			end
		end
	end
end

count(JSON.parse(File.read("input12.txt")))
puts $output
