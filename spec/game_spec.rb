require 'game'
require 'ui'
require 'minimax'
require 'computer_player'

describe Game do
  def output_from_human_human_game_with_input(input1, input2)
    output = StringIO.new
    ui = Ui.new(nil, output)

    human_player_1 = instance_double('HumanPlayer')
    allow(human_player_1).to receive(:move).and_return(*input1)
    human_player_2 = instance_double('HumanPlayer')
    allow(human_player_2).to receive(:move).and_return(*input2)

    game = Game.new(ui, [human_player_1, human_player_2])
    game.run
    
    output
  end

  describe 'run' do
    context 'run game' do
      it 'plays a human/human game to end' do
        output = output_from_human_human_game_with_input([1, 4, 7], [2, 5])
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
        output = output_from_human_human_game_with_input([1, 4, 7], [2, 5])
        expect(output.string).to include('X', 'O', '1', '│', '└')
      end

      it 'prints who won' do
        output = output_from_human_human_game_with_input([1, 4, 7], [2, 5])
        expect(output.string).to include('X won')
      end

      it 'prints that it is a tie' do
        output = output_from_human_human_game_with_input([1, 7, 6, 8, 3], [5, 4, 2, 9])
        expect(output.string).to include('tie')
      end
    end
  end
end
