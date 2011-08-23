class MarsRover
  attr_accessor :path, :x, :y, :direction, :plateau
  
  def initialize x, y, direction, plateau
    self.x, self.y, self.direction, self.plateau = x, y, direction, plateau
    init_directions
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
    path.upcase.split('').each do |action| 
      case action
        when 'L' 
          left
        when 'R'
          right
        when 'M'
          move
      end
    end
  end
end

class Plateau
  attr_accessor :width, :height
  def initialize width, height
    self.width, self.height = width, height   
  end
  def inside? x, y
    x>0 && y>0 && x<self.width && y<self.height
  end
end

# usage
plateau = Plateau.new 5,5
first_marsrover = MarsRover.new 1, 2, 'N', plateau
first_marsrover.movement 'LMLMLMLMM'

second_marsrover = MarsRover.new 3,3,'E', plateau
second_marsrover.movement 'MMRMMRMRRM'