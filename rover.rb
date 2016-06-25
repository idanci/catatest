class Rover
  attr_reader :position, :direction

  DIRECTIONS = ["N", "W", "S", "E"]

  def initialize(position, direction)
    @position = position
    @direction = direction
  end

  def spin(side)
    raise ArgumentError unless ["L", "R"].include?(side)
    current_direction = DIRECTIONS.index(direction)
    @direction = if side == "L"
      DIRECTIONS[current_direction + 1]
    else
      DIRECTIONS[current_direction - 1]
    end
  end
end
