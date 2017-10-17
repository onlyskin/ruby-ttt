require 'game'
require 'ui'
require 'minimax'
require 'computer_player'

describe Game do
  describe 'run' do
    context 'run game' do
      it 'plays a human/human game to end' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        players = [HumanPlayer.new(ui), HumanPlayer.new(ui)]
        game = Game.new(ui, players)

        game.run

        expect(game.game_over?).to eq(true)
        expect(output.string).to include('X won')
      end

      it 'plays a human/computer game to end' do
        input = StringIO.new("1\n4\n2\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        computer_player = instance_double(ComputerPlayer)
        minimax = instance_double(Minimax)
        allow(minimax).to receive(:minimax)
                      .and_return([5, 10], [7, 10], [3, 10])
        players = [HumanPlayer.new(ui), ComputerPlayer.new(minimax)]
        game = Game.new(ui, players)

        game.run

        expect(output.string).to include('O won')
      end

      it 'turns board in to printable string for each move made' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        players = [HumanPlayer.new(ui), HumanPlayer.new(ui)]
        game = Game.new(ui, players)

        game.run

        expect(output.string).to include('X', 'O', '1', '│', '└')
      end

      it 'prints user messages and error messages' do
        input = StringIO.new("1\n2\n4\n5\n20\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        players = [HumanPlayer.new(ui), HumanPlayer.new(ui)]
        game = Game.new(ui, players)

        game.run

        expect(output.string).to include('move')
        expect(output.string).to include('valid')
      end

      it 'prints who won' do
        input = StringIO.new("1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        players = [HumanPlayer.new(ui), HumanPlayer.new(ui)]
        game = Game.new(ui, players)

        game.run

        expect(output.string).to include('X won')
      end

      it 'prints that it is a tie' do
        input = StringIO.new("1\n5\n7\n4\n6\n2\n8\n9\n3\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        players = [HumanPlayer.new(ui), HumanPlayer.new(ui)]
        game = Game.new(ui, players)

        game.run

        expect(output.string).to include('tie')
      end
    end
  end
end
