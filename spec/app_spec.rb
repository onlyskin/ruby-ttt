require 'app.rb'
require 'ui.rb'
require 'ui_spy.rb'

describe App do
  describe 'run' do
    context 'run app' do
      it 'plays the game until the end' do
        input = StringIO.new("7\n4\n6\n2\n8\n9\n3\nthis_doesnt_get_read\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        board = Board.new
        board = board.play(1)
        board = board.play(5)
        app = App.new(ui, board)
        app.run
        expect(app.game_over?).to eq(true)
      end
      it 'turns board in to printable string for each move made' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)
        app.run
        expect(output.string).to include('X', 'O', '1', '│', '└')
      end
      it 'prints user messages and error messages' do
        input = StringIO.new("1\n2\n4\n5\n20\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)
        app.run
        expect(output.string).to include('move')
        expect(output.string).to include('valid')
      end
    end
  end
end
