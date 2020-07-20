class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def is_valid_input?(input)
    input.kind_of?(String) && input.length == 1
  end

  def guess
    p "-------------------------------------------------"
    p "Player #{@name}"
    p "Please enter a character:"

    input = gets.chomp

    if !self.is_valid_input?(input)
      p "Invalid input, please enter only one character..."
      return self.guess
    end

    input
  end
end