# frozen_string_literal: true

require_relative 'player'
require 'colorize'
require 'pry-byebug'

class Tile
  attr_accessor :position, :color

  def initialize(position)
    self.position = position
    self.color = :white
  end
end
