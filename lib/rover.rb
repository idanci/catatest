class Rover
  attr_reader :x, :y, :direction

  DIRECTIONS = ["N", "W", "S", "E"]
  SIDES      = ["L", "R"]

  def initialize(x, y, direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    @direction = direction
    @x, @y     = x, y
  end

  def position
    [x, y]
  end

  def execute_instruction(instruction)
    if instruction == "M"
      move
    elsif SIDES.include?(instruction)
      spin(instruction)
    else
      raise ArgumentError.new("Only following instructions are supported: 'M', 'L', 'R'")
    end
  end

private

  def spin(side)
    raise ArgumentError unless SIDES.include?(side)

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
