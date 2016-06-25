class Expedition
  attr_reader :x, :y, :rovers

  def initialize(x, y)
    @x, @y  = x.to_i, y.to_i
    @rovers = []
  end

  def corner
    [x, y]
  end

  def deploy_rover(x, y, direction, name=nil)
    unless (1..self.x).include?(x.to_i) or (1..self.y).include?(y.to_i)
      raise "Don't deploy rovers outside plateau!"
    end

    rover = Rover.new(x, y, direction, corner, name)
    @rovers << rover
    rover
  end

  def move_rover(rover, instructions_set)
    if instructions_set.is_a?(Array)
      rover.execute_instructions_set(instructions_set)
    elsif instructions_set.is_a?(String)
      rover.execute_instructions_set(instructions_set.scan(/[mlr]/i))
    else
      raise ArgumentError.new("Please use only 'M', 'L', 'R' instructions.")
    end
  end

  def find_rover(name)
    @rovers.detect { |rover| rover.name == name }
  end
end
