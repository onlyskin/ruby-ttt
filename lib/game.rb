require_relative 'board'
require_relative 'move_requester'

class Game
  def initialize(ui)
    @ui = ui
    @move_requester = MoveRequester.new(@ui)
    @board = Board.new
  end

  def run
    @ui.output(@board.to_s)
    until @board.game_over?
      move = @move_requester.request(@board)
      @board = @board.play(move)
      @ui.output(@board.to_s)
    end
    if @board.tie?
        @ui.output('The game ended in a tie.')
    else
        @ui.output("#{@board.winner} won.")
    end
  end

  def game_over?
    @board.game_over?
  end
end
