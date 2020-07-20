require_relative "Player.rb"

class Game
  attr_reader :players, :fragment

  def initialize(player_1_name, player_2_name)
    @players = [Player.new(player_1_name), Player.new(player_2_name)]
    @fragment = ""
    # @dictionary = IO.readlines("dictionary.txt", chomp: true).map!(&:to_sym)
    @dictionary = IO.readlines("dictionary.txt", chomp: true).to_set
  end

  def current_player
    @players.first
  end
  
  def previous_player
    @players.last
  end

  def next_player!
    @players.rotate!
  end

  def take_turn(player)
    guess = player.guess

    if self.valid_play?(guess)
      @fragment = @fragment + guess
      p "Good guess!"
      p "Current string is: #{@fragment}"
      p "-------------------------------------------------"
    else
      player.alert_invalid_guess
      p "There is no such word in dictionary"
      p "Good luck on your next turn!"
      p "Current string is: #{@fragment}"
      p "-------------------------------------------------"
    end
  end

  def valid_play?(string)
    @dictionary.each do |word|
      regexp  = Regexp.new(@fragment + string)

      if regexp === word
        return true
      end
    end
      
    false
  end

  def play_round
    self.take_turn(self.current_player)

    if @dictionary.include?(@fragment)
      p "Player #{current_player.name} wins!"
      p "Player #{previous_player.name} loses!"
      p "GAME OVER"
      return
    else
      p "playing round..."
    end

    p "moving along...q"
    self.next_player!
    self.play_round
  end
end