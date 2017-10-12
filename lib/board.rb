class Board

    PATHS = [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 4, 8],
        [6, 4, 2],
    ]
    MARKERS = ['O', 'X']

    def initialize(cells=['-', '-', '-', '-', '-', '-', '-', '-', '-'])
        @cells = cells.clone
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
        MARKERS[available_moves.length % 2]
    end

    def winner
        PATHS.each do |first, second, third|
            if @cells[first] == @cells[second] && @cells[second] == @cells[third] && @cells[third] != '-'
                return @cells[first]
            end
        end
        false
    end

    def winner?
        !!winner 
    end

    def tie?
        if full? && !winner?
            return true
        end
        false
    end

    def game_over?
        winner? || tie?
    end

    def play(move)
        @cells[move-1] = current_marker
    end

    #def play2(move)
    #    self
    #end

    def to_s
        result = ""
        (0..8).each do |i|
            result << @cells[i]
            if i % 3 == 2
                result << "\n"
            end
        end
        result
    end

    private
    def full?
        available_moves.length == 0
    end
end
