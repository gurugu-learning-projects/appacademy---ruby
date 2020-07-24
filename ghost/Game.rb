require_relative "Player.rb"

class Game
  MAX_LOSS_COUNT = 5

  attr_reader :players, :fragment, :losses

  def initialize(*player_names)
    @players = player_names.map {|name| Player.new(name)}
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).to_set
    @losses = Hash.new {|losses, player| losses[player] = 0}
  end

  def run
    while @players.length > 1
      self.play_round
      self.show_score
      self.remove_winning_word
      self.remove_ghost_players
      @fragment = ""
    end

    self.final_score
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
      p "You got the letter right"
      p "That's dangerous! Be careful next time"
    else
      p "Phew!"
      p "There is no such word in dictionary"
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
    @losses[self.current_player.name] += 1
  end

  def show_score
    ghost = "GHOST"

    p "Current Rating:"

    @losses.each do |player_name, losses|
      p "#{player_name} --- #{ghost[0...losses]}"
    end
  end

  def player_is_ghost?
    @losses.has_value?(MAX_LOSS_COUNT)
  end

  def who_is_ghost
    ghosts = @losses.select {|k,v| v == MAX_LOSS_COUNT} 

    ghosts.keys
  end

  def final_score
    ghosts = self.who_is_ghost
    p "-------------------------------------------------"
    p "GHOSTS:"

    ghosts.each do |name, losses|
      p name
    end

    p "-------------------------------------------------"
    p "WINNER:"
    p @players[0].name
  end

  def remove_ghost_players
    ghosts = self.who_is_ghost

    @players.reject! do |player|
      ghosts.include?(player.name)
    end
  end

  def remove_winning_word
    @dictionary.delete(@fragment)
  end

  def play_round
    while !@dictionary.include?(@fragment)
      self.take_turn(self.current_player)
      self.next_player!
    end

    p "Player #{current_player.name} finished the word!"

    self.count_losses
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new(
    Player.new("Gizmo"), 
    Player.new("Breakfast"), 
    Player.new("Toby"),
    Player.new("Leonardo")
    )

  game.run
end