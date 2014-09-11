class Maze 
  
  attr_reader :maze, :start, :exit, :agent, :path, :deadend
  attr_accessor :current_position
  
  def initialize(filename)
    @maze = File.readlines(filename)
    @start = self.maze_find("S")
    @exit = self.maze_find("E")
    @agent = Agent.new
    @deadend = []
    @path = []
    self.current_position = self.start
  end
  
  def position(pos)
    return self.maze[pos[0]][pos[1]]
  end
  
  def maze_find(letter)
    self.maze.length.times do |y|
      self.maze.first.length.times do |x|
        return [y,x] if self.position([y,x]) == letter
      end
    end
  end
  
  def move(pos)
    self.maze[pos[0]][pos[1]] = "X"
    self.path << pos
    self.current_position = pos
  end
  
  def move?(pos)
    return self.position(pos) == ' ' || self.at_exit?(pos) 
  end
  
  def not_dead?(pos)
    return !self.deadend.include?(pos)
  end
  
  def not_been?(pos)
    return !self.path.include?(pos)
  end
  
  def at_exit?(pos)
    return pos == self.exit
  end
  
  def revert_move(pos)
    self.deadend << pos
    self.current_position = self.path.pop
    self.maze[pos[0]][pos[1]] = " "
  end
  
  def find_path
    puts "self at exit is #{self.at_exit?(self.current_position)}"
    until self.at_exit?(self.current_position)
      new_pos = self.agent.move(self.current_position)
      if !self.not_dead?(new_pos)
        self.revert_move(current_position)
        p "dead ends are #{self.deadend.to_s}"
      elsif self.move?(new_pos) && self.not_been?(new_pos) && self.not_dead?(new_pos)
        puts "found a new move at #{new_pos}"
        self.render
        self.move(new_pos)
      else
        next
      end
    end
    p self.path
    self.render
  end
  
  def render
    puts self.start
    puts self.exit
    p self.position([2,2])
    self.maze.each {|row| puts "#{row}"}
  end
end

class Agent
  MOVELIST = ['up', 'down', 'left', 'right']

  def move(position)
    return self.move_location(MOVELIST.sample, position)
  end
  
  def move_location(direction, position)
    case direction
    when "up"
      return [position[0]-1, position[1]]
    when "down"
      return [position[0]+1, position[1]]
    when "left"
      return [position[0], position[1]-1]
    when "right"
      return [position[0], position[1]+1]
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new('./maze.txt')
  maze.render
  maze.find_path
  
end