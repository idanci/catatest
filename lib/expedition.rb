class Expedition
  attr_reader :corner
  def initialize(x, y)
    @corner = [x, y]
  end

  def deploy(x, y, direction)
    Rover.new(x, y, direction)
  end
end
