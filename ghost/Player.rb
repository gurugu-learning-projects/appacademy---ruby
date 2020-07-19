class Player
  def initialize(name)
    @name = name
  end

  def is_valid_input?(input)
    input.kind_of?(String) && input.length == 1
  end

  def guess
    p "Player #{@name}"
    p "Please enter a character:"

    input = gets.chomp

    if !self.is_valid_input?(input)
      p "Invalid input, please enter only one character..."
      p "-------------------------------------------------"
      return self.guess
    end

    input
  end

  def alert_invalid_guess 
    p "There is no such word in dictionary"
    p "Good luck on your next turn!"
    p "-------------------------------------------------"
  end
end