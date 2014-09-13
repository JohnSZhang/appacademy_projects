require "./poly_tree_node"

class KnightPathFinder
  attr_accessor :move_tree, :position, :visited_positions

  def initialize(position)
    @position = position
    @visited_positions = []
    @move_tree = build_move_tree(position)
  end

  #move helpers

  def self.up position
    [position.first - 1, position.last]
  end

  def self.down position
    [position.first + 1, position.last]
  end

  def self.left position
    [position.first, position.last - 1]
  end

  def self.right position
    [position.first, position.last + 1]
  end

  def self.on_board?(pos)
    board = Array.new(8) { Array.new(8) {' '} }
    row = !board[pos.first].nil? && pos.first > 0
    column = !board[0][pos.last].nil? && pos.last > 0
    (row && column)
  end

  def self.valid_moves(pos)
    valid_moves = []

    all_moves = []

    all_moves << up(left(left(pos)))
    all_moves << down(left(left(pos)))
    all_moves << up(right(right(pos)))
    all_moves << down(right(right(pos)))
    all_moves << left(up(up(pos)))
    all_moves << right(up(up(pos)))
    all_moves << left(down(down(pos)))
    all_moves << right(down(down(pos)))

    all_moves.each do |move|
      valid_moves << move if on_board?(move)
    end

    valid_moves
  end

  def new_move_positions(pos)

    new_move_positions = KnightPathFinder.valid_moves(pos).reject do |pos|
      self.visited_positions.include?(pos)
    end
    self.visited_positions = visited_positions + new_move_positions

    new_move_positions
  end

  def build_move_tree(pos)
    root_node = PolyTreeNode.new(pos)
    move_nodes = [root_node]

    until move_nodes.empty?
      parent_node = move_nodes.shift
      new_moves = new_move_positions(parent_node.value)

      new_moves.each do |move|
        child_node = PolyTreeNode.new(move)
        child_node.parent = parent_node
        move_nodes << child_node
      end
    end

    root_node
  end

  def find_path(target_value)
    target_node = self.move_tree.dfs(target_value)
    p self.move_tree.trace_path_back(target_node)
  end


end