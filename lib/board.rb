class Board
    def initialize
        @cells = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
        @Markers = ['O', 'X']
    end

    def available_moves
        result = []
        @cells.each_with_index do |v, i|
            if v == '-'
                result.push(i+1)
            end
        end
        result
    end

    def current_marker
        @Markers[available_moves.length % 2]
    end

    def play(move)
        @cells[move-1] = 'X'
    end
end
