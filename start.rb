require_relative "lib/nasa"

puts "Input upper-right coordinates of the plateau, X and Y"
coords = gets.chomp.scan(/\d/)[0..1]

expedition = Expedition.new(*coords)
rovers     = []

["R2D2", "Curiosity"].each do |name|
  begin
    puts "Deploy #{name} rover, input it's coordinates and direction"
    input     = gets.chomp
    coords    = input.scan(/\d/)[0..1]
    direction = input.scan(/[#{Rover::DIRECTIONS.join}]/i).last
    expedition.deploy_rover(coords.first, coords.last, direction, name)
  rescue
    retry
  end
  begin
    puts "Provide instructions for the #{name} rover, use 'L', 'R' and 'M'"
    input     = gets.chomp
    rover     = expedition.find_rover(name)
    expedition.move_rover(rover, input)
  rescue LostInSpace => error
    puts error.message
    retry
  end
end

expedition.rovers.each do |rover|
  puts "#{rover.position.join}#{rover.direction}"
end


# 5 5
# 1 2 N
# LMLMLMLMM

# 3 3 E
# MMRMMRMRRM
