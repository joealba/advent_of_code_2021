#!/usr/bin/env ruby

BAD_PARSE_SCORE = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

INCOMPLETE_SCORE = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}

class BracketParser
  attr_reader :input
  attr_accessor :stack

  OPEN = [ 91.chr, '(', '{', '<' ]
  CLOSE = [ 93.chr, ')', '}', '>' ]

  def initialize(input)
    @input = input
    @stack = []
  end

  def parse
    input.chars.each do |char|
      if OPEN.include?(char)
        stack << char
      else
        if ret = try_close(char)
          return ret
        end
      end
    end

    nil
  end

  def parse_for_incomplete
    input.chars.each do |char|
      if OPEN.include?(char)
        stack << char
      else
        if ret = try_close(char)
          return nil
        end
      end
    end

    stack.reverse.flat_map{|c| CLOSE[OPEN.index(c)]}
  end

  def try_close(char)
    CLOSE.index(char) == OPEN.index(stack.pop) ? nil : char
  end
end

input = File.readlines('./input.txt')

# Part 1
input.flat_map do |line|
  BAD_PARSE_SCORE[BracketParser.new(line.chomp).parse]
end.compact.sum

# Part 2
scores = input.map do |line|
  BracketParser.new(line.chomp).parse_for_incomplete
end.compact.map{|res| res.inject(0){ |total, c| total * 5 + INCOMPLETE_SCORE[c] }}.sort

puts scores[(scores.length/2).ceil]
