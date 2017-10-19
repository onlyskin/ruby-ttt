require 'board'

describe Board do
  describe '#initialize' do
    it 'all moves available' do
      board = Board.new
      expect(board.available_moves).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it '1 is not available' do
      cells = ['X', '-', '-', '-', '-', '-', '-', '-', '-']
      board = Board.new(cells: cells)
      expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe '#available_moves' do
    it 'at start is 1-9 be default' do
      board = Board.new
      expect(board.available_moves).to eq(Array (1..9))
    end
    xit 'at start is 1-16 when init with 4' do
      board = Board.new(4)
      expect(board.available_moves).to eq(Array (1..16))
    end
    it 'after calling #play(1), 1 is unavailable' do
      board = board_with_moves([1])
      expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
    end

    it 'after calling #play(2), 2 is unavailable' do
      board = board_with_moves([2])
      expect(board.available_moves).to eq([1, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe '#current_marker' do
    it 'X at start' do
      board = described_class.new
      expect(board.current_marker).to eq('X')
    end
    
    it 'O after one play' do
      board = board_with_moves([1])
      expect(board.current_marker).to eq('O')
    end
  end

  describe '#tie?' do
    it 'false when full board with winner' do
      board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 3, 9])
      expect(board.tie?).to be false
    end

    it 'true when full board no winner' do
      board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
      expect(board.tie?).to be true
    end

    it 'false when not full with winner' do
      board = board_with_moves([7, 8, 5, 6, 3])
      expect(board.tie?).to be false
    end

    it 'false when not full no winner' do
      board = board_with_moves([7, 8, 5, 6])
      expect(board.tie?).to be false
    end
  end

  describe '#game_over?' do
    it 'true when there is a winner' do
      board = board_with_moves([7, 8, 5, 6, 3])
      expect(board.game_over?).to be true
    end

    it 'false when no winner and board not full' do
      board = board_with_moves([7, 8, 5, 6])
      expect(board.game_over?).to be false
    end

    it 'true when there is a tie' do
      board = board_with_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
      expect(board.game_over?).to be true
    end

    it 'true when X wins in left column' do
      board = board_with_moves([1, 2, 4, 5, 7])
      expect(board.game_over?).to be true
    end

    it 'true when X wins in third row' do
      board = board_with_moves([7, 4, 8, 5, 9])
      expect(board.game_over?).to be true
    end

    it 'true when X wins on second diagonal' do
      board = board_with_moves([7, 8, 5, 6, 3])
      expect(board.game_over?).to be true
    end
  end

  describe 'play' do
    it 'game is over when X winning sequence played' do
      board = board_with_moves([1, 2, 4, 5, 7])
      expect(board.game_over?).to be true
    end
  end

  describe 'winner' do
    it 'when X wins returns X' do
      board = board_with_moves([1, 2, 4, 5, 7])
      expect(board.winner).to eq('X')
    end

    it 'when O wins returns O' do
      board = board_with_moves([2, 1, 5, 4, 3, 7])
      expect(board.winner).to eq('O')
    end
  end

  describe 'to_s' do
    it 'returns string representation when to_s called' do
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
