#!/usr/bin/env ruby

class PositionTracker
  Position = Struct.new(:horizontal, :depth, :aim)

  attr_accessor :position
  attr_reader :operations_part_1, :operations_part_2

  def initialize
    @position = Position.new(0, 0, 0)

    @operations_part_1 = {
      "forward" => -> (inc) do
        position.horizontal += inc
      end,
      "down" => -> (inc) do
        position.depth += inc
      end,
      "up" => -> (inc) do
        position.depth -= inc
      end,
    }

    @operations_part_2 = {
      "forward" => -> (inc) do
        position.horizontal += inc
        position.depth += position.aim * inc
      end,
      "down" => -> (inc) do
        position.aim += inc
      end,
      "up" => -> (inc) do
        position.aim -= inc
      end,
    }
  end

  def run_part_1(cmd, amt)
    operations_part_1[cmd].call(amt)
  end

  def run_part_2(cmd, amt)
    operations_part_2[cmd].call(amt)
  end

  def value
    position.horizontal * position.depth
  end
end

filename = './input.txt'
input = File.readlines(filename)

position_tracker = PositionTracker.new
input.each do |line|
  (cmd, amt) = line.chomp.split(/\s/)
  position_tracker.run_part_1(cmd, amt.to_i)
end
puts position_tracker.value

position_tracker = PositionTracker.new
input.each do |line|
  (cmd, amt) = line.chomp.split(/\s/)
  position_tracker.run_part_2(cmd, amt.to_i)
end
puts position_tracker.value

