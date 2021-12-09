#!/usr/bin/env ruby

readings = File.readlines("./input.txt").map(&:to_i)
(1..readings.length - 1).select{|i| readings[i] > readings[i-1]}.count

