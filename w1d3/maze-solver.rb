require 'set'
class Maze 
  
  attr_reader :maze, :start, :exit, :agent
  
  def initialize(filename)
    @maze = File.readlines(filename).map(&:chomp).map
    @maze = maze.map{|row| row.split('')}

    @start = self.maze_find("S")
    puts "start at #{@start}"
    @exit = self.maze_find("E")
    puts "ends at #{@exit}"
  end
  
  def position(pos)
    self.maze[pos[0]][pos[1]]
  end
  
  def maze_find(letter)
    self.maze.length.times do |y|
      self.maze.first.length.times do |x|
        return [y,x] if self.position([y,x]) == letter
      end
    end
  end
  
  def move?(pos)
    return self.position(pos) == ' ' || self.position(pos) == 'E'
  end
  
  def at_exit?(pos)
    return pos == self.exit
  end
  
  
  def find_path
    @agent = Agent.new(self)
    render(self.agent.find_paths)
  end
  
  def render(path = nil)
    if path
      path[1..-2].each do |pos|
        self.maze[pos.first][pos.last] = "X"
      end
    end
    self.maze.each{ |row| puts row.join('') } 
  end
end

class Agent
  attr_accessor :position,:maze,:paths
  
  MOVELIST = ['up', 'down', 'left', 'right']
  def initialize(maze)
    self.maze = maze
    self.position = maze.start
    self.paths = Set.new([[self.position]])
  end
  
  def random_move(position)
     self.move_location(MOVELIST.sample, position)
  end
  
  def move_location(direction, position)
    case direction
    when "up"
      [position.first-1, position.last]
    when "down"
      [position.first+1, position.last]
    when "left"
      [position.first, position.last-1]
    when "right"
      [position.first, position.last+1]
    end
  end
  
  def path_step(path)
    pos = path.last
    
    all_pos = MOVELIST.map{|direction| move_location(direction, pos)}  
    legal_pos = all_pos.select{|pos| maze.move?(pos) && !path.include?(pos)}
    
    return nil if legal_pos == []
    
    legal_pos.map{|legal| path.dup << legal}
  end
  
  
  
  def find_paths
    path_length = 0
    while true
      new_paths = Set.new
      end_pos = Set.new
      self.paths.each do |path|

        pos = path.last
        step_paths = path_step(path)
        next unless step_paths 
      
        step_paths.each do |possible_path|
          
          next if end_pos.include?(possible_path.last)
          end_pos << possible_path.last 
          
          if self.maze.at_exit?(possible_path.last)
            puts "found solution!!"
            #puts "#{possible_path.to_s}"
            return possible_path 
          end
          if !new_paths.include?(possible_path)
            new_paths << possible_path 
          end    
        end
      end
      path_length += 1
      self.paths = new_paths
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new('./maze.txt')
  maze.render
  maze.find_path
  
end