input = 265149
ary = []
i = 1
loop do
  x = Math.sqrt(i)
  if x == x.to_i
    ary.push i
    break if i >= input
  end
  i += 2
end
last = ary.last
side = Math.sqrt(last).to_i
remainder = input % (side - 1)
remainder = side - 1 if remainder.zero?
max_distance = side - 1
min_distance = max_distance / 2
min_distance_remainder = (side / 2.0).ceil
result = case remainder
         when 1
           max_distance
         when min_distance_remainder
           min_distance
         else
           (side - 1) / 2 + (min_distance_remainder - remainder).abs
         end
puts result
