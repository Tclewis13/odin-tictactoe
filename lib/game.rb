require_relative 'tile'
require_relative 'player'
require_relative 'display'
require 'pry-byebug'

class Game
  WINSTATES = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]], [[0, 0], [1, 0], [2, 0]],
               [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]], [[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]].freeze

  attr_accessor :type, :win, :turn, :tile_array, :red_player, :blue_player, :game_display

  def initialize(t)
    self.type = t
    self.win = ''
    self.turn = :red
    self.tile_array = Array.new(3) { Array.new(3) }

    type == 'pvp'

    self.red_player = Player.new(:red, 'human')
    self.blue_player = Player.new(:blue, 'human')

    zero_zero_tile = Tile.new([0, 0])
    tile_array[0][0] = zero_zero_tile
    zero_one_tile = Tile.new([0, 1])
    tile_array[0][1] = zero_one_tile
    zero_two_tile = Tile.new([0, 2])
    tile_array[0][2] = zero_two_tile
    one_zero_tile = Tile.new([1, 0])
    tile_array[1][0] = one_zero_tile
    one_one_tile = Tile.new([1, 1])
    tile_array[1][1] = one_one_tile
    one_two_tile = Tile.new([1, 2])
    tile_array[1][2] = one_two_tile
    two_zero_tile = Tile.new([2, 0])
    tile_array[2][0] = two_zero_tile
    two_one_tile = Tile.new([2, 1])
    tile_array[2][1] = two_one_tile
    two_two_tile = Tile.new([2, 2])
    tile_array[2][2] = two_two_tile

    self.game_display = Display.new(tile_array)

    game_flow
  end

  def check_for_win
    WINSTATES.each do |state|
      if tile_array[state[0][0]][state[0][1]].color == :red && tile_array[state[1][0]][state[1][1]].color == :red && tile_array[state[2][0]][state[2][1]].color == :red
        self.win = :red
      end
      if tile_array[state[0][0]][state[0][1]].color == :blue && tile_array[state[1][0]][state[1][1]].color == :blue && tile_array[state[2][0]][state[2][1]].color == :blue
        self.win = :blue
      end
    end
  end

  def game_flow
    puts ''
    puts ''
    puts 'Starting game. Red player goes first, then blue player.'

    while win == ''
      prompt_player
      check_for_win
    end
  end

  def get_player_from_color(color)
    if color == :red then red_player
    elsif color == :blue then blue_player
    end
  end

  def prompt_player
    puts "#{turn} player's turn. Select row for move."
    move_row = gets.chomp.to_i
    puts "#{turn} player's turn. Select column for move."
    move_column = gets.chomp.to_i
    make_move(get_player_from_color(turn), [move_row, move_column])
  end

  def make_move(player, position)
    tile_array[position[0]][position[1]].color = player.color
    game_display.print_display
  end
end
