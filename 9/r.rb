#!/usr/bin/env ruby

require 'matrix'

Point = Struct.new(:x, :y)

class HeightMap
  attr_reader :matrix
  attr_accessor :visited_for_basin_detection

  BASIN_MAX = 9

  def initialize(matrix)
    @matrix = matrix
    @visited_for_basin_detection = Set.new
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

  def detect_basin_for_point(point)
    visited_for_basin_detection = Set.new
    return nil if point_value(point) == BASIN_MAX

    expand_basin_detection_from_point(point).uniq
  end

  def expand_basin_detection_from_point(point)
    pts = adjacent_points(point).reject do |pt|
      point_value(pt) == BASIN_MAX || visited_for_basin_detection.include?(pt)
    end

    visited_for_basin_detection.merge pts

    [point, pts.flat_map { |pt| expand_basin_detection_from_point(pt) }].flatten
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

# input = File.readlines("./input.txt")
# height_map = HeightMap.new(Matrix.rows(input.map{|line| line.chomp.split('').map(&:to_i)}))

# height_map.risk_level
# low_points = height_map.low_points

# basins = low_points.map{|lp| height_map.detect_basin_for_point(lp)}
# basins.map(&:length).sort.last(3).reduce(&:*)
