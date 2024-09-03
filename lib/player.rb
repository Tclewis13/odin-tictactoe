require 'pry-byebug'

class Player
  attr_accessor :color, :type

  def initialize(c, t)
    self.color = c
    self.type = t
  end
end
