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
  end

  def game_over?
    @board.game_over?
  end
end
