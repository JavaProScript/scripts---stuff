# frozen_string_literal: true

# script to change a range [a, b] to another [a', b'] while conserving proportions
puts 'Enter the minimal value of the range.'
puts '>'
old_min = gets.chomp.to_i
puts 'Enter the maximal value of the range.'
puts '>'
old_max = gets.chomp.to_i
puts 'Enter the coefficient y between 1 and 2 that will be the zoom applied to the range.'
puts '>'
y = gets.chomp.to_f

old_range = old_max - old_min
old_median = (old_max + old_min) / 2

test_array = []

i = 0
while i <= 10
  test_array.push(old_min + old_range * i)
  i += 1
end

test_array.each do |x|
  x_prime = (x - old_median) / y + old_median
  puts "#{x} with coefficient #{y} is #{x_prime}."
end
