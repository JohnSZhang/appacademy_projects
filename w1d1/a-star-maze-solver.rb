def maze_solver
  maze = File.new('./maze.txt', "r")
  maze_array = []
  while (line=maze.gets)
    maze_array << line
  end
  maze.close
  exit = maze_special(maze_array, "E")
  start = maze_special(maze_array, "S")
  closed = [start]
  open = find_legal_moves(maze_array, closed)
  heuristics = []
  open.each do |cell|
    heuristics << manhattan(cell, exit)
  end

  while (not closed.include? exit)
    mindex = index_of_minimum(heuristics)
    closed << open[mindex]
    heuristics = []
    open = find_legal_moves(maze_array,closed)
    open.each do |cell|
      heuristics << manhattan(cell, exit)
    end
  end

  return closed
end

def index_of_minimum(heuristics)
  mindex = 0
  for i in 0...heuristics.length
    if heuristics[i] < heuristics[mindex]
      mindex = i
    end
  end
  return mindex
end

def manhattan(cell1, cell2)
  x1 = cell1[1]
  x2 = cell2[1]
  y1 = cell1[0]
  y2 = cell2[0]
  return (x1-x2).abs + (y1-y2).abs
end

def find_legal_moves(maze_array, closed)
  open = []
  closed.each do |cell|
    ['u', 'd', 'l', 'r'].each do |direction|
      if movable?(direction, maze_array, cell)
        open << move_result(direction, cell)
      end
    end
  end
end

def move_result(direction, last_position)
  x = last_position[1]
  y = last_position[0]
  case direction
  when "u"
    return [y-1, x]
  when "d"
    return [y+1, x]
  when "l"
    return [y, x-1]
  when "r"
    return [y, x+1]
  else
    return false
  end
end

def movable?(direction, maze_array, last_position)
  x = last_position[1]
  y = last_position[0]
  case direction
  when "u"
    if maze_array[y-1][x] == ' '
      return true
    else
      return false
    end
  when "d"
    if maze_array[y+1][x] == ' '
      return true
    else
      return false
    end
  when "l"
    if maze_array[y][x-1] == ' '
      return true
    else
      return false
    end
  when "r"
    if maze_array[y][x+1] == ' '
      return true
    else
      return false
    end
  else
    return false
  end
end


print maze_solver