input = STDIN.read
stream = input.each_char
overall_score = 0
next_score = 1
in_garbage = false
garbage_count = 0
loop do
  case stream.next
  when '!'
    stream.next if in_garbage
  when '{'
    if in_garbage
      garbage_count += 1
    else
      overall_score += next_score
      next_score += 1
    end
  when '}'
    if in_garbage
      garbage_count += 1
    elsif next_score > 1
      next_score -= 1
    end
  when '<'
    if in_garbage
      garbage_count += 1
    else
      in_garbage = true
    end
  when '>'
    if in_garbage
      in_garbage = false
    else
      garbage_count += 1
    end
  else
    garbage_count += 1 if in_garbage
  end
end
puts overall_score
puts garbage_count
