puts(File.readlines('input2').reduce(0) do |memo, line|
  ary = line.split.map(&:to_i)
  # memo + (ary.max - ary.min) #Part One
  result = nil
  ary.each do |n|
    x = ary.find {|x| x % n == 0 or n % x == 0}
    unless x.nil? or x == n
      result = [x, n].sort
      break
    end
  end
  memo + result.last / result.first
end)
