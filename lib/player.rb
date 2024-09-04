# frozen_string_literal: true

require 'pry-byebug'

class Player
  attr_accessor :color, :type

  def initialize(color, type)
    self.color = color
    self.type = type
  end
end
