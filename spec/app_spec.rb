require 'App'

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

describe App do
    describe 'output' do
        context 'call with string' do
            it 'puts to output' do
                input = StringIO.new("test input\n")
                output = StringIO.new()
                app = App.new(input, output)
                app.output('test output')
                expect(output.string).to eq("test output\n")
            end
        end
    end
    describe 'input' do
        context 'call' do
            it 'gets input' do
                input = StringIO.new("test input\n")
                output = StringIO.new()
                app = App.new(input, output)
                expect(app.input).to eq("test input")
            end
        end
    end
    describe 'run' do
        context 'run app' do
            it 'calls play on BoardSpy with input until no more available moves' do
                input = StringIO.new("7\n4\n6\n2\n8\n9\n3\nthis_doesnt_get_read\n")
                output = StringIO.new()
                board_spy = BoardSpy.new()
                board_spy.play(1)
                board_spy.play(5)
                app = App.new(input, output, board_spy)
                app.run()
                expect(board_spy.play_called).to be true
                expect(board_spy.play_called_with).to eq([1, 5, 7, 4, 6, 2, 8, 9, 3])
            end
            it 'stops when board.game_over? is true' do
                input = StringIO.new("1\n2\n4\n5\n7\n")
                output = StringIO.new()
                board_spy = BoardSpy.new()
                app = App.new(input, output, board_spy)
                app.run()
                expect(board_spy.play_called_with).to eq([1, 2, 4, 5, 7])
            end
            it 'calls to_s on board_spy six times' do
                input = StringIO.new("1\n2\n4\n5\n7\n")
                output = StringIO.new()
                board_spy = BoardSpy.new()
                app = App.new(input, output, board_spy)
                app.run()
                expect(board_spy.to_s_called_count).to eq(6)
            end
        end
    end
end
