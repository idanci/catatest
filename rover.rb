class Rover
  attr_reader :position, :direction

  DIRECTIONS = ["N", "W", "S", "E"]

  def initialize(position, direction)
    @position = position
    @direction = direction
  end

  def spin(side)
    raise ArgumentError unless ["L", "R"].include?(side)

  end
end
