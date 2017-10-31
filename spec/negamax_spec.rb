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
  end

  def board_from_s(string)
    Board.new(cells: string.split(''))
  end
end
