require_relative 'tile'
require_relative 'player'
require_relative 'display'
require 'pry-byebug'

class Game
  WINSTATES = [[[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]], [[0, 0], [1, 0], [2, 0]],
               [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]], [[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]].freeze

  attr_accessor :type, :win, :turn, :tile_array, :red_player, :blue_player, :game_display

  def initialize(type)
    self.type = type
    self.win = ''
    self.turn = :red
    self.tile_array = Array.new(3) { Array.new(3) }

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
        puts ''
        puts ''
        puts 'Red player wins!'
      end
      if tile_array[state[0][0]][state[0][1]].color == :blue && tile_array[state[1][0]][state[1][1]].color == :blue && tile_array[state[2][0]][state[2][1]].color == :blue # rubocop:disable Style/Next
        self.win = :blue
        puts ''
        puts ''
        puts 'Blue player wins!'
      end
    end
    row_zero = tile_array[0]
    row_one = tile_array[1]
    row_two = tile_array[2]

    return unless row_zero.none? { |tile| tile.color == :white } && row_one.none? { |tile| tile.color == :white } && row_two.none? { |tile| tile.color == :white } && win == '' # rubocop:disable Layout/LineLength

    self.win = :draw
    puts ''
    puts ''
    puts 'Draw Game!'
  end

  def game_flow
    puts ''
    puts ''
    puts 'Starting game. Red player goes first, then blue player.'

    while win == ''
      prompt_player
      check_for_win
      if turn == :red then self.turn = :blue
      elsif turn == :blue then self.turn = :red
      end
    end
  end

  def get_player_from_color(color)
    if color == :red then red_player
    elsif color == :blue then blue_player
    end
  end

  def prompt_player
    puts "#{turn} player's turn. Select row for move."
    move_row = gets.chomp
    if move_row.count('a-zA-Z').positive?
      puts 'Invalid Value! Input your move again starting with row.'
      prompt_player
    end
    move_row = move_row.to_i
    puts "#{turn} player's turn. Select column for move."
    move_column = gets.chomp
    if move_column.count('a-zA-Z').positive?
      puts 'Invalid Value! Input your move again starting with row.'
      prompt_player
    end
    move_column = move_column.to_i
    make_move(get_player_from_color(turn), [move_row, move_column])
  end

  def make_move(player, position)
    if check_valid(position)
      tile_array[position[0]][position[1]].color = player.color
      game_display.print_display
    else
      puts 'Invalid Value! Input your move again starting with row.'
      prompt_player
    end
  end

  def check_valid(position)
    return false if !position[0].between?(0, 2) || !position[1].between?(0, 2)
    return false if tile_array[position[0]][position[1]].color != :white

    true
  end
end
