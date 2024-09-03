require_relative 'player'
require 'colorize'
require 'pry-byebug'

class Tile
  attr_accessor :position, :color

  def initialize(p)
    self.position = p
    self.color = :white
  end
end
