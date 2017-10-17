require_relative 'board'
require_relative 'move_requester'

class Game
  def initialize(ui)
    @ui = ui
    @move_requester = MoveRequester.new(@ui)
    @board = Board.new
  end

  def run
    output_board
    until @board.game_over?
      run_turn
    end
    end_message
  end

  def game_over?
    @board.game_over?
  end

  private

  def run_turn
    move = @move_requester.request(@board)
    @board = @board.play(move)
    output_board
  end

  def output_board
    @ui.output(@board.to_s)
  end

  def end_message
    if @board.tie?
      @ui.output('The game ended in a tie.')
    else
      @ui.output("#{@board.winner} won.")
    end
  end
end
