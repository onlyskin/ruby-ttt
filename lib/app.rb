require_relative 'board'

class App
    def initialize(ui, board = Board.new)
        @board = board
        @ui = ui
    end

    def run
        @ui.output(@board.to_s)
        while !@board.game_over?
            move = @ui.input.to_i
            @board = @board.play(move)
            @ui.output(@board.to_s)
        end
    end
end
