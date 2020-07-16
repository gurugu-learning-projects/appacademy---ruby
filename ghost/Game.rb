require_relative "Player.rb"

class Game
  attr_accessor :players

  def initialize(player_1_name, player_2_name)
    @players = [Player.new(player_1_name), Player.new(player_2_name)]
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).map!(&:to_sym)
  end

  def current_player
    @players.first
  end
  
  def previous_player
    @players.last
  end

  def next_player!
  end

  def take_turn(player)
  end

  def valid_play?(string)
  end

  def play_round
  end
end