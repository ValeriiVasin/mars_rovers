class Plateau
  attr_accessor :width, :height
  def initialize width, height
    self.width, self.height = width, height
  end
  def inside? x, y
    x>=0 && y>=0 && x<=self.width && y<=self.height
  end
end

class MarsRover
  attr_accessor :path, :x, :y, :direction, :plateau
  
  def initialize x, y, direction, plateau
    self.x, self.y, self.direction, self.plateau = x, y, direction, plateau
    init_directions
    init_actions
  end
  
  def init_directions
    @directions = [
      { :x =>  1, :y =>  0, :direction => 'E' },
      { :x =>  0, :y =>  1, :direction => 'N' },
      { :x => -1, :y =>  0, :direction => 'W' },
      { :x =>  0, :y => -1, :direction => 'S' },
    ]
    @directions.rotate!(['E','N','W','S'].index self.direction)
  end
  
  def init_actions
    @actions = {
      'L' => lambda{ left },
      'R' => lambda{ right },
      'M' => lambda{ move }
    }
  end

  def left
    @directions.rotate!
  end
  
  def right
    @directions.rotate!(-1)
  end
  
  def move
    if self.plateau.inside? next_x, next_y
      self.x = next_x
      self.y = next_y
    end
  end
  
  def next_x
    self.x + @directions[0][:x]
  end
  
  def next_y
    self.y + @directions[0][:y]
  end
  
  def movement path
    path.upcase.split('').each { |action| @actions[action].call }
  end

  def result
    "#{self.x} #{self.y} #{@directions[0][:direction]}"
  end
end

data = File.open('input.txt', 'r'){ |file| file.read }.split("\n");
plateau_coords = data.shift.split().map { |element| element.to_i };
plateau = Plateau.new *plateau_coords

file = File.new('output.txt','w');
n=data.length
1.step(n,2) do |i|
  x, y, direction = data[i-1].split()
  mars_rover = MarsRover.new x.to_i, y.to_i, direction, plateau
  mars_rover.movement data[i]
  file.puts mars_rover.result
end
file.close