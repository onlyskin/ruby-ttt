require 'computer_player'
require 'negamax'
require 'board'

describe ComputerPlayer do
  describe 'move' do
    it 'calls negamax on injected negamax' do
      negamax = instance_double(Negamax)
      allow(negamax).to receive(:negamax)
                    .and_return([1, 10])
      computer_player = ComputerPlayer.new(negamax)
      board = instance_double(Board)

      computer_player.move(board)

      expect(negamax).to have_received(:negamax)
    end
    
    it 'takes winning move' do
      negamax = Negamax.new
      computer_player = ComputerPlayer.new(negamax)
      board = Board.new(cells: ['X', 'O', '-', 'X', 'O', '-', '-', '-', '-'])

      move = computer_player.move(board)

      expect(move).to eq(7)
    end
  end
end
