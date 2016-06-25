class Expedition
  attr_reader :corner, :rovers

  def initialize(x, y)
    @corner = [x, y]
    @rovers = []
  end

  def deploy_rover(x, y, direction, name=nil)
    rover = Rover.new(x, y, direction, name)
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
