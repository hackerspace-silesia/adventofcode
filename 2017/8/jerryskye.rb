input = File.read('venv/2017/input8')
hsh = Hash.new(0)
max = 0
input.each_line do |line|
  eval(line.gsub(/[a-z]+/) do |match|
    case match
    when 'inc'
      '+='
    when 'dec'
      '-='
    when 'if'
      'if'
    else
      "hsh[:#{match}]"
    end
  end)
  current_max = hsh.values.max
  max = current_max if current_max > max
end
puts hsh.values.max
puts max
