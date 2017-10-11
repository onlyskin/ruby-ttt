require_relative 'board.rb'

class App
    def initialize(input=$stdin, output=$stdout, board=Board.new)
        @output = output
        @input = input
        @board = board
    end

    def run
        output(@board.to_s)
        while @board.available_moves.length > 0
            break if @board.game_over?
            move = input.to_i
            @board.play(move)
            output(@board.to_s)
        end
    end

    def output(string)
        @output.puts(string)
    end

    def input
        @input.gets.chomp
    end
end
