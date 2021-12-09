#!/usr/bin/env ruby

require 'matrix'

Point = Struct.new(:x, :y)

class HeightMap
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def adjacent_points(point)
    [up(point), down(point), left(point), right(point)].compact
  end

  def low_points
    (0..matrix.row_size - 1).flat_map do |row|
      (0..matrix.column_size - 1).flat_map do |column|
        point = Point.new(column, row)
        point_values(adjacent_points(point)).all? { |value| value > point_value(point) } ? point : nil
      end.compact
    end.flatten
  end

  def risk_level
    point_values(low_points).map{ |v| v + 1 }.sum
  end

  def point_value(point)
    matrix[point.y, point.x]
  end

  def point_values(points)
    points.map { |point| point_value(point) }
  end

  private

  def up(point)
    return nil if point.y <= 0
    Point.new(point.x, point.y - 1)
  end

  def down(point)
    return nil if point.y >= matrix.row_size - 1
    Point.new(point.x, point.y + 1)
  end

  def left(point)
    return nil if point.x <= 0
    Point.new(point.x - 1, point.y)
  end

  def right(point)
    return nil if point.x >= matrix.column_size - 1
    Point.new(point.x + 1, point.y)
  end
end

input = File.readlines("./input.txt")
height_map = HeightMap.new(Matrix.rows(input.map{|line| line.chomp.split('').map(&:to_i)}))

height_map.risk_level