#!/usr/bin/env ruby

# part 1

input = File.readlines("./input.txt")

gamma = (0..input.first.chomp.length - 1).flat_map do |i|
  input.select{|line| line[i] == "0"}.count > input.count / 2 ? "0" : "1"
end.join

epsilon = gamma.chars.map{|c| c == "0" ? "1" : "0"}.join

puts gamma.to_i(2) * epsilon.to_i(2)

# part 2
filtered = input
(0..filtered.first.chomp.length - 1).each do |i|
  last if filtered.count == 1

  common = filtered.select{|line| line[i] == "0"}.count > filtered.count / 2 ? "0" : "1"
  filtered = filtered.select{|line| line[i] == common}
end

oxygen_rating = filtered.first.chomp


filtered = input
(0..filtered.first.chomp.length - 1).each do |i|
  last if filtered.count == 1

  puts i
  common = filtered.select{|line| line[i] == "0"}.count > filtered.count / 2 ? "1" : "0"
  filtered = filtered.select{|line| line[i] == common}

  puts common
  puts filtered
  puts
end

co2_rating = filtered.first.chomp


puts oxygen_rating.to_i(2) * co2_rating.to_i(2)
