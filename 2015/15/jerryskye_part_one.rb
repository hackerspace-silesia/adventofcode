class Ingredient
  attr_accessor :name, :cap, :dur, :flav, :tex, :cal, :prop

  def initialize(name, cap, dur, flav, tex)
    @name = name[0..-2]
    @cap = cap.chomp.to_i
    @dur = dur.chomp.to_i
    @flav = flav.chomp.to_i
    @tex = tex.chomp.to_i
    @cal = cal.to_i
    @prop = 0
  end

  def to_s
    "Ingredient: #@name\n\tCapacity: #@cap\n\tDurability: #@dur\n\tFlavour: #@flav\n\tTexture: #@tex\n\tCalories: #@cal\n"
  end

end

def calc(arr, *amounts)
  map = {}

  total_capacity = 0
  total_durability = 0
  total_flavour = 0
  total_texture = 0
  total_calories = 0

  arr.each do |item|
    total_capacity += item.prop * item.cap
    total_durability += item.prop * item.dur
    total_flavour += item.prop * item.flav
    total_texture += item.prop * item.tex
    total_calories += item.prop * item.cal
  end

  totals = [total_capacity, total_durability, total_flavour, total_texture]
  return 0 if totals.any? { |n| n <= 0 }

  return totals.inject(:*)
end

input = File.readlines("input15.txt")

ingredients = []

input.each do |ingredient|
  spl = ingredient.split(" ")
  ingredients << Ingredient.new(spl[0], spl[2], spl[4], spl[6], spl[8])
end

highest_total = 0

(0..100).each do |i|
  (0..100).each do |j|
    if i+j <= 100
      (0..100).each do |k|
        if i + j + k <= 100
          (0..100).each do |l|
            if i + j + k + l == 100
              narr = [i, j, k, l]
              narr.each_with_index {|num, idx| ingredients[idx].prop = num}
              total = calc(ingredients, narr)
              if total > highest_total
                highest_total = total
              end
            end
          end
        end
      end
    end
  end
end

puts highest_total
