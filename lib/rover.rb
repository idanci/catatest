class Rover
  attr_reader :x, :y, :direction

  DIRECTIONS = ["N", "W", "S", "E"]

  def initialize(x, y, direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    @direction  = direction
    @x, @y     = x, y
  end

  def position
    [x, y]
  end

private

  def spin(side)
    raise ArgumentError unless ["L", "R"].include?(side)

    current_direction = DIRECTIONS.index(direction)
    @direction = if side == "L"
      DIRECTIONS[current_direction + 1]
    else
      DIRECTIONS[current_direction - 1]
    end
  end

  def move
    case direction
    when "N"
      @y += 1
    when "W"
      @x -= 1
    when "S"
      @y -= 1
    when "E"
      @x += 1
    end
  end
end
