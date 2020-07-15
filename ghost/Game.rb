class Game
  def initialize
    @players = "trst"
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).map!(&:to_sym)
  end

  def play_round
  end
end