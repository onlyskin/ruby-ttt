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

    def winner
        paths = [
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 4, 8],
            [6, 4, 2],
        ]
        paths.each do |first, second, third|
            if @cells[first] == @cells[second] && @cells[second] == @cells[third] && @cells[third] != '-'
                return @cells[first]
            end
        end
        false
    end

    def winner?()
        !!winner 
    end

    def tie?()
        if _full? && !winner?
            return true
        end
        return false
    end

    def play(move)
        @cells[move-1] = current_marker
    end

    def _full?
        available_moves.length == 0
    end
end
