# frozen_string_literal: true

require_relative 'tile'
require 'pry-byebug'

class Display
  attr_accessor :tiles

  def initialize(tiles)
    self.tiles = tiles
    print_display
  end

  def print_display
    (0..2).each do |x|
      puts ''
      (0..2).each do |y|
        print '[]'.colorize(tiles[x][y].color)
      end
    end
    puts ''
    puts ''
  end
end
