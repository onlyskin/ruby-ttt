require_relative 'board.rb'

class App
    def initialize(ui, board=Board.new)
        @board = board
        @ui = ui
    end

    def run
        @ui.output(@board.to_s)
        while @board.available_moves.length > 0
            break if @board.game_over?
            move = @ui.input.to_i
            @board.play(move)
            @ui.output(@board.to_s)
        end
    end
end
