require_relative 'board'

# A class to manage the running of a game
class App
  def initialize(ui, board = Board.new)
    @board = board
    @ui = ui
  end

  def game_over?
      @board.game_over?
  end

  def run
    @ui.output(@board.to_s)
    until @board.game_over?
      move = @ui.input.to_i
      @board = @board.play(move)
      @ui.output(@board.to_s)
    end
  end
end
