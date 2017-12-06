class Bank
  attr_accessor :val

  def initialize value
    @val = value
  end
end

current_state = STDIN.read.split.map {|x| Bank.new x.to_i}
states = {current_state.map(&:val) => 0}
loop do
  max = current_state.max_by(&:val)
  value = max.val
  i = current_state.index max
  cycle = current_state.cycle
  max.val = 0
  (i + 1).times { cycle.next }
  value.times { cycle.next.val += 1 }
  ary = current_state.map(&:val)
  break if states.include? ary
  states[ary] = states.count
end
puts states.count
puts states.count - states[current_state.map(&:val)]
