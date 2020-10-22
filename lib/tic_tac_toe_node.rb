require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    evaluator == :x ? opponent = :o : opponent = :x
    if @board.over?
      @board.winner == opponent ? (return true) : (return false)
    end

    if evaluator == @next_mover_mark
      return true if children.all? { |child| child.losing_node?(evaluator)}
    else
      return true if children.any? { |child| child.losing_node?(evaluator)}
    end
    false
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator ? (return true) : (return false)
    end

    if evaluator == @next_mover_mark
      return true if children.any? { |child| child.winning_node?(evaluator)}
    else
      return true if children.all? { |child| child.winning_node?(evaluator)}
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    (0..2).each do |row|
      (0..2).each do |col|
        child_board = @board.dup
        pos = [row, col]

        next unless child_board.empty?(pos)
        child_board[pos] = @next_mover_mark

        next_next_mover_mark = @next_mover_mark == :x ? :o : :x
        arr << TicTacToeNode.new(child_board, next_next_mover_mark, pos)

      end
    end
    arr
  end

end
