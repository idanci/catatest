class Expedition
  attr_reader :corner

  def initialize(x, y)
    @corner = [x, y]
  end

  def deploy_rover(x, y, direction)
    Rover.new(x, y, direction)
  end

  def move_rover(rover, instructions_set)
    if instructions_set.is_a?(Array)
      instructions_set.each { |instruction| rover.execute_instruction(instruction) }
    elsif instructions_set.is_a?(String)
      instructions_set.scan(/[mlr]/i).each { |instruction| rover.execute_instruction(instruction) }
    else
      raise ArgumentError.new("Please use only 'M', 'L', 'R' instructions.")
    end
  end
end
