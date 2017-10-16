require 'minimax'
require 'board'

describe Minimax do

  minimax = Minimax.new()

  describe 'minimax' do
    context 'current player has winning move' do
      it 'X takes winning move' do
        board = board_from_s('XO-XO----')
        expect(minimax.minimax(board, nil, 0)[0]).to eq(7)
      end
      it 'O takes winning move' do
        board = board_from_s('XX-OO-X--')
        expect(minimax.minimax(board, nil, 0)[0]).to eq(6)
      end
    end
    context 'opposing player would have winning move' do
      it 'blocks opposing player winning move' do
        board = board_from_s('X--XO-O--')
        expect(minimax.minimax(board, nil, 0)[0]).to eq(3)
      end
    end
  end

  describe 'score' do
    context 'calling player wins' do
      it 'returns 10' do
        board = board_from_s('XO-XO-X--')
        expect(minimax.score(board, 'X')).to eq(10)
      end
    end
    context 'there is a tie' do
      it 'returns 0' do
        board = board_from_s('XOXXOXOXO')
        expect(minimax.score(board, 'O')).to eq(0)
      end
    end
    context 'the other player wins' do
      it 'returns -10' do
        board = board_from_s('XO-XO-X--')
        expect(minimax.score(board, 'O')).to eq(-10)
      end
    end
  end

  def board_from_s(string)
    Board.new(string.split(''))
  end
end
