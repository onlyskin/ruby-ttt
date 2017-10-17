require 'board'

describe Board do
  describe 'initialize' do
    context 'no argument' do
      it 'all moves available' do
        board = Board.new
        expect(board.available_moves).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
    context 'cells given with first being X' do
      it '1 is not available' do
        cells = ['X', '-', '-', '-', '-', '-', '-', '-', '-']
        board = Board.new(cells)
        expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
  end

  describe 'available_moves' do
    context 'after calling #play(1)' do
      it '1 is unavailable' do
        board = board_with_moves([1])
        expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
    context 'after calling #play(2)' do
      it '2 is unavailable' do
        board = board_with_moves([2])
        expect(board.available_moves).to eq([1, 3, 4, 5, 6, 7, 8, 9])
      end
    end
  end

  describe 'current_marker' do
    context 'at start' do
      it 'is X' do
        board = described_class.new
        expect(board.current_marker).to eq('X')
      end
    end
    context 'after one play' do
      it 'is O' do
        board = board_with_moves([1])
        expect(board.current_marker).to eq('O')
      end
    end
  end

  describe 'tie?' do
    context 'full board with winner' do
      it 'returns false' do
        board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 3, 9])
        expect(board.tie?).to be false
      end
    end
    context 'full board no winner' do
      it 'returns true' do
        board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
        expect(board.tie?).to be true
      end
    end
    context 'not full board with winner' do
      it 'returns false' do
        board = board_with_moves([7, 8, 5, 6, 3])
        expect(board.tie?).to be false
      end
    end
    context 'not full board no winner' do
      it 'returns false' do
        board = board_with_moves([7, 8, 5, 6])
        expect(board.tie?).to be false
      end
    end
  end

  describe 'game_over?' do
    context 'when there is a winner' do
      it 'returns true' do
        board = board_with_moves([7, 8, 5, 6, 3])
        expect(board.game_over?).to be true
      end
    end
    context 'when there is no winner and board is not full' do
      it 'returns false' do
        board = board_with_moves([7, 8, 5, 6])
        expect(board.game_over?).to be false
      end
    end
    context 'when there is a tie' do
      it 'returns true' do
        board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
        expect(board.game_over?).to be true
      end
    end
    context 'X wins in left column' do
      it 'returns true' do
        board = board_with_moves([1, 2, 4, 5, 7])
        expect(board.game_over?).to be true
      end
    end
    context 'X wins in third row' do
      it 'returns true' do
        board = board_with_moves([7, 4, 8, 5, 9])
        expect(board.game_over?).to be true
      end
    end
    context 'X wins on second diagonal' do
      it 'returns true' do
        board = board_with_moves([7, 8, 5, 6, 3])
        expect(board.game_over?).to be true
      end
    end
  end

  describe 'play' do
    context 'when X winning sequence played' do
      it 'game is over' do
        board = board_with_moves([1, 2, 4, 5, 7])
        expect(board.game_over?).to be true
      end
    end
  end

  describe 'winner' do
    context 'when X wins' do
      it 'returns X' do
        board = board_with_moves([1, 2, 4, 5, 7])
        expect(board.winner).to eq('X')
      end
    end

    context 'when O wins' do
      it 'returns O' do
        board = board_with_moves([2, 1, 5, 4, 3, 7])
        expect(board.winner).to eq('O')
      end
    end

    context 'when no winner' do
      it 'raises error' do
        board = board_with_moves([2, 1, 5, 4, 3])
        expect { board.winner }.to raise_error
      end
    end
  end

  describe 'to_s' do
    context 'to_s called' do
      it 'returns string representation' do
        board = board_with_moves([7, 8, 5, 6])
        expected = %(┌───┬───┬───┐
│ 1 │ 2 │ 3 │
│───│───│───│
│ 4 │ X │ O │
│───│───│───│
│ X │ O │ 9 │
└───┴───┴───┘)
        expect(board.to_s).to eq(expected)
      end
    end
  end

  def board_with_moves(moves)
    board = described_class.new
    play_moves(board, moves)
  end

  def play_moves(board, moves)
    moves.each do |move|
      board = board.play(move)
    end
    board
  end
end
