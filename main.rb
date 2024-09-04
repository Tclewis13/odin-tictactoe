# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/tile'
require 'rubocop'
require 'colorize'
require 'pry-byebug'

Game.new('pvp')
