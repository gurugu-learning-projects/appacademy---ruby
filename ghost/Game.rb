require_relative "Player.rb"

class Game
  MAX_LOSS_COUNT = 5

  attr_reader :players, :fragment, :losses

  def initialize(*player_names)
    @players = player_names.map {|name| Player.new(name.chomp)}
    @fragment = ""
    @dictionary = IO.readlines("dictionary.txt", chomp: true).to_set
    @losses = {}

    player_names.each {|player_name| @losses[player_name.chomp] = 0}
  end

  def run
    self.play_round until game_over?

    self.final_score
  end

  def play_round
    @fragment = ""
    self.before_round

    until round_over?
      self.take_turn
      self.next_player!
    end

    self.after_round
  end

  def before_round
    system("clear") || system("cls")
    puts "Let's play a round of Ghost!"
    sleep(2)

    puts "\n"
    puts "Current rating:"
    
    ghost = "GHOST"
    @losses.each do |player_name, losses|
      puts "#{player_name} --- #{ghost[0...losses]}"
    end
  end

  def after_round
    system("clear") || system("cls")
    puts "#{current_player.name} spelled #{@fragment}."
    puts "#{current_player.name} gets a letter!"
    sleep(3)

    if @losses[self.current_player.name] == MAX_LOSS_COUNT - 1
      puts "#{current_player.name} has been eliminated!"
      sleep(3)
    end

    @losses[self.current_player.name] += 1
    self.remove_winning_word
    self.remove_ghost_players
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def game_over?
    players.length < 2
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

  def remove_ghost_players
    ghosts = self.who_is_ghost

    @players.reject! do |player|
      ghosts.include?(player.name)
    end
  end
  
  def who_is_ghost
    ghosts = @losses.select {|k,v| v == MAX_LOSS_COUNT} 

    ghosts.keys
  end

  def take_turn
    guess = self.current_player.guess

    puts "\n"
    if self.valid_play?(guess)
      @fragment = @fragment + guess
      puts "You got the letter right"
      puts "That's dangerous! Be careful next time"
    else
      puts "Phew!"
      puts "There is no such word in dictionary"
    end
    
    puts "\n"
    puts "Current string is: #{@fragment}"
    puts "\n"
    sleep(1)
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

  def remove_winning_word
    @dictionary.delete(@fragment)
  end

  def final_score
    puts "#{@players[0].name} wins!"
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