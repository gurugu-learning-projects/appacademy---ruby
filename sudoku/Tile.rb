class Tile
  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def to_s
    given.to_s
  end
end