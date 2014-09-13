class PolyTreeNode
  attr_accessor :children, :value
  attr_reader :parent

  def initialize(value)
    @parent = nil
    self.children = []
    self.value = value
  end

  def parent=(new_parent)
    @parent.children.delete(self) unless @parent.nil?

    if new_parent.nil?
      @parent = nil
      return
    end


    @parent = new_parent
    unless new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise RunTimeError unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(value)
    return self if self.value == value

    self.children.each do |child|
      dfs_result = child.dfs(value)
      return dfs_result unless dfs_result.nil?
    end

    nil
  end

  def bfs(value)
    node_queue = []
    node_queue << self
    until node_queue.empty?
      current_node = node_queue.shift
      return current_node if current_node.value == value
      node_queue += current_node.children
    end
  end

  def trace_path_back(target_node)

    temp_node = target_node
    path_array = []
    until temp_node.parent.nil?
      path_array << temp_node.value
      temp_node = temp_node.parent
    end
    path_array << temp_node.value

    path_array.reverse
  end

end


if __FILE__ == $PROGRAM_NAME
  nodes = []
  (0..7).each do |value|
    nodes[value] = PolyTreeNode.new(value)
  end

  nodes[0].add_child(nodes[1])
  nodes[0].add_child(nodes[2])
  nodes[1].add_child(nodes[3])
  nodes[1].add_child(nodes[4])
  nodes[2].add_child(nodes[5])
  nodes[2].add_child(nodes[6])

  p nodes[0].bfs(0)
  puts "searched for 0"
  puts "\n"
  p nodes[0].bfs(8)
  puts "searched for 8"
  puts "\n"
  p nodes[0].bfs(5)
  puts "searched for 5"


end