require_relative "Player.rb"

class Game
  attr_reader :players, :fragment, :losses

  def initialize(player_1_name, player_2_name)
    @players = [Player.new(player_1_name), Player.new(player_2_name)]
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).to_set
    @losses = {}

    @players.each do |player|
      losses[player.name] = 0
    end
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
    else
      p "There is no such word in dictionary"
      p "Good luck on your next turn!"
    end
    
    p "Current string is: #{@fragment}"
  end

  def valid_play?(string)
    @dictionary.each do |word|
      regexp  = Regexp.new("^#{@fragment}#{string}")
      if regexp === word
        return true
      end
    end
      
    false
  end

  def add_loss
    @losses[self.previous_player] += 1
  end

  def play_round
    # self.take_turn(self.current_player)

    # if @dictionary.include?(@fragment)
    #   p "Player #{current_player.name} wins!"
    #   p "Player #{previous_player.name} loses!"
    #   p "GAME OVER"
    #   return
    # end

    while !@dictionary.include?(@fragment)
      self.take_turn(self.current_player)
      self.next_player!
    end

    p "Player #{current_player.name} wins this round!"
    p "Player #{previous_player.name} gets ghosted: #{}"

    self.add_loss
    # self.next_player!
    # self.play_round
  end
end