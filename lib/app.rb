require_relative 'board'
require_relative 'move_requester'

# A class to manage the running of a game
class App
  def initialize(ui, board = Board.new)
    @board = board
    @ui = ui
    @move_requester = MoveRequester.new(@ui)
  end

  def game_over?
      @board.game_over?
  end

  def run
    @ui.output(@board.to_s)
    until @board.game_over?
      move = @move_requester.request(@board)
      @board = @board.play(move)
      @ui.output(@board.to_s)
    end
  end
end
