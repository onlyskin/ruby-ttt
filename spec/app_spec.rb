require 'app.rb'
require 'board_spy.rb'

describe App do
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
