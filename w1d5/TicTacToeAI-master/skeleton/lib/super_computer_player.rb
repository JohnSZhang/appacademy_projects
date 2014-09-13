require_relative 'tic_tac_toe_node'
#require 'debugger'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    opponent_mark = mark == :o ? :x : :o
    new_node = TicTacToeNode.new(game.board, mark)
    node_children = new_node.children

    # debugger

    node_children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    node_children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
end
    p node_children.count


    raise RuntimeError, "NO MOVES, YOU SUCK AT THIS!!"
  end
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
