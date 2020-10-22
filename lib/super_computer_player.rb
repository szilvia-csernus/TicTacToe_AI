require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    mark == :x ? opponent = :o : opponent = :x
    ttt = TicTacToeNode.new(game.board, mark)
    children = ttt.children
    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end
    
    raise "There is no non-losing nodes!"

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("You")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
