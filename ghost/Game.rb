class Game
  def initialize
    @players = "trst"
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).map!(&:to_sym)
  end

  def current_player
  end
  
  def previous_player
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