#!/usr/bin/env ruby

# part 1

input = File.readlines("./input.txt")

gamma = (0..input.first.chomp.length - 1).flat_map do |i|
  input.select{|line| line[i] == "0"}.count > input.count / 2 ? "0" : "1"
end.join

epsilon = gamma.chars.map{|c| c == "0" ? "1" : "0"}.join

puts gamma.to_i(2) * epsilon.to_i(2)

