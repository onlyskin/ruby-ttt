require 'game'
require 'ui'

describe Game do
  describe 'run' do
    context 'run game' do
      it 'plays the game until the end' do
        input = StringIO.new("1\n5\n7\n4\n6\n2\n8\n9\n3\nthis_doesnt_get_read\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        game = Game.new(ui)

        game.run

        expect(game.game_over?).to eq(true)
      end

      it 'turns board in to printable string for each move made' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        game = Game.new(ui)

        game.run

        expect(output.string).to include('X', 'O', '1', '│', '└')
      end

      it 'prints user messages and error messages' do
        input = StringIO.new("1\n2\n4\n5\n20\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        game = Game.new(ui)

        game.run

        expect(output.string).to include('move')
        expect(output.string).to include('valid')
      end

      it 'prints who won' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        game = Game.new(ui)

        game.run

        expect(output.string).to include('X won')
      end

      it 'prints that it is a tie' do
        input = StringIO.new("1\n5\n7\n4\n6\n2\n8\n9\n3\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        game = Game.new(ui)

        game.run

        expect(output.string).to include('tie')
      end
    end
  end
end
