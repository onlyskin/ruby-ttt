require 'minimax'
require 'board'

describe Minimax do
  minimax = Minimax.new

  describe 'minimax' do
    it 'X takes winning move' do
      board = board_from_s('XO-XO----')
      expect(minimax.minimax(board, nil, 0)[0]).to eq(7)
    end

    it 'O takes winning move' do
      board = board_from_s('XX-OO-X--')
      expect(minimax.minimax(board, nil, 0)[0]).to eq(6)
    end

    it 'blocks opposing player winning move' do
      board = board_from_s('X--XO-O--')
      expect(minimax.minimax(board, nil, 0)[0]).to eq(3)
    end

    it 'O plays in center' do
      board = board_from_s('X--------')
      expect(minimax.minimax(board, nil, 0)[0]).to eq(5)
    end
  end

  def board_from_s(string)
    Board.new(cells: string.split(''))
  end
end
