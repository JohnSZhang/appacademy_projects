require_relative 'tic_tac_toe'
#require 'debugger'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    if self.board.over?
      return false if self.board.winner.nil? || self.board.winner == evaluator
      return true if self.board.winner != evaluator
    end



    if next_mover_mark == evaluator
      children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
     # debugger
      children.any? do |child|
        child.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if self.board.over?
      return true if self.board.winner == evaluator
      return false if self.board.winner.nil? || self.board.winner != evaluator
    end

    if next_mover_mark == evaluator
      children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      children.all? do |child|
        child.winning_node?(evaluator)
      end
    end


  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    @board.cols.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|

        current_position = [row_index,column_index]

        new_board = board.dup
        next_move = self.next_mover_mark == :x ? :o : :x

        if @board[current_position].nil?
          new_board[[row_index,column_index]] = self.next_mover_mark
          children_nodes << TicTacToeNode.new(new_board,next_move,current_position)
        else
          next
        end

      end
    end
    children_nodes
  end

end
