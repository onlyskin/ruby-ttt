class Board
    def initialize()
        @cells = ['-','-','-','-','-','-','-','-','-']
    end

    def [](key)
        @cells[key]
    end

    def []=(key, value)
        @cells[key] = value
    end

    def availableSpaces
        [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
end
