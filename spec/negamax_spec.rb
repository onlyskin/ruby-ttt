require 'negamax'
require 'board'

describe Negamax do
  negamax = Negamax.new

  describe 'negamax' do
    it 'X takes winning move' do
      board = board_from_s('XO-XO----')
      expect(negamax.negamax(board)[0]).to eq(7)
    end

    it 'O takes winning move' do
      board = board_from_s('XX-OO-X--')
      expect(negamax.negamax(board)[0]).to eq(6)
    end

    it 'blocks opposing player winning move' do
      board = board_from_s('X--XO-O--')
      expect(negamax.negamax(board)[0]).to eq(3)
    end

    it 'O plays in center' do
      board = board_from_s('X--------')
      expect(negamax.negamax(board)[0]).to eq(5)
    end
    
    it 'can handle a 4x4 game' do
      board = board_from_s('----------------', size: 4)
      negamax.negamax(board)
    end
  end

  def board_from_s(string, size: 3)
    Board.new(cells: string.split(''), size: size)
  end
end
