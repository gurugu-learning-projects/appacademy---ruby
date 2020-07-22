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

  def count_losses
    @losses[self.previous_player.name] += 1
  end

  def show_score
    ghost = "GHOST"

    p "Current Rating:"

    @losses.each do |player_name, losses|
      p "#{player_name} --- #{ghost[0...losses]}"
    end
  end

  def player_is_ghost?
    @losses.has_value?(5)
  end

  def who_is_ghost
    ghosts = @losses.select {|k,v| v == 5}

    ghosts.each do |name, losses|
      p name if losses == 5
    end
  end

  def play_round
    while !@dictionary.include?(@fragment)
      self.take_turn(self.current_player)
      self.next_player!
    end

    p "Player #{current_player.name} wins this round!"

    self.count_losses
  end

  def run
    while !self.player_is_ghost?
      self.play_round
      self.show_score
      @fragment = ""
    end

    self.who_is_ghost
  end
end