require_relative 'tile'
require 'pry-byebug'

class Display
  attr_accessor :tiles

  def initialize(t)
    self.tiles = t
    print_display
  end

  def print_display
    for x in 0..2
      puts ''
      for y in 0..2
        print '[]'.colorize(tiles[x][y].color)
      end
    end
  end
end
