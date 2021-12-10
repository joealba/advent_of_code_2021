#!/usr/bin/env ruby

SCORE = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
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
    input.chars.each_with_index do |char, i|
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

  def try_close(char)
    CLOSE.index(char) == OPEN.index(stack.pop) ? nil : char
  end
end

input = File.readlines('./input.txt')

input.flat_map do |line|
  SCORE[BracketParser.new(line.chomp).parse]
end.compact.sum
