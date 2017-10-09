class Board
    def initialize
        @cells = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
    end

    def availableMoves
        result = []
        @cells.each_with_index do |v, i|
            if v == '-'
                result.push(i+1)
            end
        end
        result
    end

    def play(move)
        @cells[move-1] = 'X'
    end
end
