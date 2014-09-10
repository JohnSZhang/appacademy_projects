def maze_solver
  maze = File.new('./maze.txt', "r")
  maze_array = []
  while (line=maze.gets)
    maze_array << line
  end
  maze.close
  exit = maze_special(maze_array, "E")
  start = maze_special(maze_array, "S")
  last_position = start
  while !check_if_solved?(maze_array, last_position, exit)
    p "maze_solver last position " + last_position.to_s
    maze_array, last_position = maze_solver_step(maze_array, last_position, exit)
    print maze_array
  end
  latest_maze = File.new('./maze_current.txt', "w")
  maze_array.each do |row|
    latest_maze.write(row)
  end
end

def maze_special(maze_array, letter)
  for i in 0...maze_array.length
    for j in 0...maze_array[i].length
      if maze_array[i][j] == letter
        return i,j
      end
    end
  end
end

def maze_solver_step(maze_array, last_position, exit)
  forbidden = []
  ["u","d","l","r"].each do |direction|
    if not movable?(direction, maze_array, last_position)
      direction + " is not movable"
      forbidden << direction
    end
  end

  if forbidden.length != 4
    direction = next_direction(maze_array, last_position, exit, forbidden)

    return move(maze_array,last_position,direction)
  else
    legal_moves = find_legal_move(maze_array)
    #[legal_maze, legal_cell, legal_direction] = find_legal_moves(maze_array)
    return move(maze_array, legal_moves[1], legal_moves[2])
  end
end

def move(maze_array,last_position,direction)
  y=last_position[0]
  x=last_position[1]
  case direction
  when 'u'
    y-=1
  when 'd'
    y+=1
  when 'l'
    x-=1
  when 'r'
    x+=1
  end
  print "move returns position" + [y,x].to_s + " direction at " + direction
  maze_array[y][x] = 'X'
  return [maze_array, [y,x]]
end

def next_direction(maze_array, last_position, exit, forbidden=[])
  move_list = ['u', 'd', 'l', 'r']
  move_list -= forbidden

  move = ''

  vertical_distance = last_position[0] - exit[0]
  horizontal_distance = last_position[1] - exit[1]

  if vertical_distance.abs >= horizontal_distance.abs
    vertical_distance > 0 ? move = 'u' : move = 'd'
  else
    horizontal_distance > 0 ? move = 'l' : move = 'r'
  end

  (move_list.include?(move)) ? (return move) : (return move_list[0])
end

=begin
def vertical_d_to_e(maze_array, last_position, exit)
  return last_position[1] > exit[1] ? "d" : "u"
end

def horizontal_d_to_e(maze_array, last_position, exit)
  return last_position[0] > exit[0] ? "l" : "r"
end
=end

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

def check_if_solved?(maze_array, last_position, exit)
  if adjacent?(last_position, exit)
    return true
  else
    return false
  end
end

def adjacent?(position1, position2)
  p position1.to_s + "\n"
  p position2.to_s + "\n"
  if((position1[0]-position2[0]).abs==1) and ((position1[1]-position2[1]).abs==0)
    return true
  elsif( (position1[1]-position2[1]).abs==1)  and ((position1[0]-position2[0]).abs==0)
    return true
  else
    return false
  end
end

def visited_cells(maze_array)
  visited = []
  for i in 0...maze_array.length
    for j in 0...maze_array[i].length
      if maze_array[i][j]=='X'
        visited <<[i,j]
      end
    end
  end
  return visited
end

def find_legal_move(maze_array)
  visited_cells = visited_cells(maze_array)
  print visited_cells.to_s
  visited_cells.each do |cell|
    ['u', 'd', 'l', 'r'].each do |direction|
      print "visited cell location" + cell.to_s
      if movable?(direction, maze_array, cell)
        return [maze_array, cell, direction]
      end
    end
  end
end



maze_solver