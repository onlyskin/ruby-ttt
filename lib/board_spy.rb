class BoardSpy < Board
    attr_reader :play_called, :play_called_with, :to_s_called_count

    def initialize
        super()
        @play_called = false
        @play_called_with = []
        @to_s_called_count = 0
    end

    def play(move)
        super(move)
        @play_called = true
        @play_called_with.push(move)
    end

    def to_s()
        super()
        @to_s_called_count += 1
    end
end

