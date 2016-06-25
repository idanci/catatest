class Rover
  attr_reader :x, :y, :direction, :playground, :name

  DIRECTIONS = ["N", "W", "S", "E"]
  SIDES      = ["L", "R"]

  def initialize(x, y, direction, playground, name="C3PO")
    raise ArgumentError unless DIRECTIONS.include?(direction.upcase)

    @direction    = direction.upcase
    @playground   = playground
    @x, @y, @name = x.to_i, y.to_i, name
  end

  def position
    [x, y]
  end

  def execute_instructions_set(instructions_set)
    initial_x, initial_y = x, y
    instructions_set.each do |instruction|
      execute_instruction(instruction)
    end
  rescue LostInSpace => error
    @x, @y = initial_x, initial_y
    raise error
  end

private

  def execute_instruction(instruction)
    if instruction == "M"
      move
    elsif SIDES.include?(instruction)
      spin(instruction)
    else
      raise ArgumentError.new("Only following instructions are supported: 'M', 'L', 'R'")
    end
    unless (1..playground.first.to_i).include?(x) and (1..playground.last.to_i).include?(y)
      raise LostInSpace.new("#{name} will be lost in space. Think before you ask him move outside the plateau.")
    end
  end

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
