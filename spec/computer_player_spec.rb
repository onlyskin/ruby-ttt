require 'computer_player'
require 'minimax'
require 'board'

describe ComputerPlayer do
  describe 'move' do
    it 'calls minimax on injected minimax' do
      minimax = instance_double(Minimax)
      allow(minimax).to receive(:minimax)
                    .and_return([1, 10])
      computer_player = ComputerPlayer.new(minimax)
      board = instance_double(Board)

      computer_player.move(board)

      expect(minimax).to have_received(:minimax)
    end
    
    it 'takes winning move' do
      minimax = Minimax.new
      computer_player = ComputerPlayer.new(minimax)
      board = Board.new(['X', 'O', '-', 'X', 'O', '-', '-', '-', '-'])

      move = computer_player.move(board)

      expect(move).to eq(7)
    end
  end
end
