class Program
  attr_reader :name
  attr_accessor :weight, :tower

  def initialize name
    @name = name
    @tower = []
  end

  def weight_of_tower
    weight + tower.reduce(0) {|memo, pr| memo + pr.weight_of_tower }
  end

  def faulty
    tower.find {|pr| tower.count {|prog| pr.weight_of_tower == prog.weight_of_tower } == 1 }
  end

  def descend
    if faulty.nil?
      puts self.weight - @@difference
    else
      @@difference = faulty.weight_of_tower - (tower - [faulty]).first.weight_of_tower
      faulty.descend
    end
  end
end

input = STDIN.read
programs = []
input.each_line do |line|
  program = programs.find {|pr| pr.name == line[/\w+/] }
  if program.nil?
    program = Program.new(line[/\w+/])
    programs.push program
  end
  program.weight = line[/\d+/].to_i
  if line.include? '->'
    program.tower = line.split('->').last.split(',').map do |name|
      programs.find {|pr| pr.name == name.strip} || Program.new(name.strip).tap {|prog| programs.push prog }
    end
  end
end

root = programs.find {|program| not programs.map(&:tower).flatten.include? program }
puts root.name
root.descend
