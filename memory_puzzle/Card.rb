class Card
  def initialize(face)
    @face = face
    @isFaceUp = false
  end

  def show_card
    if self.isFaceUp
      return self.face
    end

    return ""
  end

  def reveal
    self.isFaceUp = true
  end

  def hide
    self.isFaceUp = false
  end

  def to_s
  end

  def ==
  end
end