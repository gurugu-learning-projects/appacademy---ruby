require_relative "Player.rb"

class Game
  attr_reader :players, :fragment

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
    @players.rotate!
  end

  def take_turn(player)
    guess = player.guess

    if !self.valid_play?(guess)
      player.alert_invalid_guess
    else
      @fragment = @fragment + guess
    end
  end

  def valid_play?(string)
    if string.kind_of?(String) && string.length == 1
      @dictionary.each do |word|
        regexp  = Regexp.new(@fragment + string)

        if regexp === word
          return true
        end
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
    end

    self.next_player!
    self.play_round
  end
end