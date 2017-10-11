require 'board.rb'

describe Board do
    describe 'available_moves' do
        context 'after calling #play(1)' do
            it '1 is unavailable' do
                board = make_board_and_play_moves([1])
                expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
            end
        end
        context 'after calling #play(2)' do
            it '2 is unavailable' do
                board = make_board_and_play_moves([2])
                expect(board.available_moves).to eq([1, 3, 4, 5, 6, 7, 8, 9])
            end
        end
    end

    describe 'current_marker' do
        context 'at start'do
            it 'is X' do
                board = Board.new()
                expect(board.current_marker).to eq('X')
            end
        end
        context 'after one play' do
            it 'is O' do
                board = make_board_and_play_moves([1])
                expect(board.current_marker).to eq('O')
            end
        end
    end

    describe 'winner' do
        context 'no winner' do
            it 'returns false' do
                board = Board.new()
                expect(board.winner).to be false
            end
        end
        context 'X wins in left column' do
            it 'returns X' do
                board = make_board_and_play_moves([1, 2, 4, 5, 7])
                expect(board.winner).to eq('X')
            end
        end
        context 'O wins in centre column' do
            it 'returns O' do
                board = make_board_and_play_moves([1, 2, 3, 5, 6, 8])
                expect(board.winner).to eq('O')
            end
        end
        context 'X wins in right column' do
            it 'returns X' do
                board = make_board_and_play_moves([3, 2, 6, 5, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins in first row' do
            it 'returns X' do
                board = make_board_and_play_moves([1, 4, 2, 5, 3])
                expect(board.winner).to eq('X')
            end
        end
        context 'O wins in second row' do
            it 'returns O' do
                board = make_board_and_play_moves([1, 4, 8, 5, 9, 6])
                expect(board.winner).to eq('O')
            end
        end
        context 'X wins in third row' do
            it 'returns X' do
                board = make_board_and_play_moves([7, 4, 8, 5, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins on first diagonal' do
            it 'returns X' do
                board = make_board_and_play_moves([1, 2, 5, 3, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins on second diagonal' do
            it 'returns X' do
                board = make_board_and_play_moves([7, 8, 5, 6, 3])
                expect(board.winner).to eq('X')
            end
        end
    end

    describe 'winner?' do
        context 'there is a winner' do
            it 'returns true' do
                board = make_board_and_play_moves([7, 8, 5, 6, 3])
                expect(board.winner?()).to be true
            end
        end
        context 'there is no winner' do
            it 'returns false' do
                board = make_board_and_play_moves([7, 8, 5, 6])
                expect(board.winner?()).to be false
            end
        end
    end

    describe 'tie?' do
        context 'full board with winner' do
            it 'returns false' do
                board = make_board_and_play_moves([1, 5, 7, 4, 6, 2, 8, 3, 9])
                expect(board.tie?()).to be false
            end
        end
        context 'full board no winner' do
            it 'returns true' do
                board = make_board_and_play_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
                expect(board.tie?()).to be true
            end
        end
        context 'not full board with winner' do
            it 'returns false' do
                board = make_board_and_play_moves([7, 8, 5, 6, 3])
                expect(board.tie?()).to be false
            end
        end
        context 'not full board no winner' do
            it 'returns false' do
                board = make_board_and_play_moves([7, 8, 5, 6])
                expect(board.tie?()).to be false
            end
        end
    end
    describe 'game_over?' do
        context 'when there is a winner' do
            it 'returns true' do
                board = make_board_and_play_moves([7, 8, 5, 6, 3])
                expect(board.game_over?()).to be true
            end
        end
        context 'when there is no winner and board is not full' do
            it 'returns false' do
                board = make_board_and_play_moves([7, 8, 5, 6])
                expect(board.game_over?()).to be false
            end
        end
        context 'when there is a tie' do
            it 'returns true' do
                board = make_board_and_play_moves([1, 5, 7, 4, 6, 2, 8, 9, 3])
                expect(board.game_over?()).to be true
            end
        end
    end

    describe 'play' do
        context 'when X winning sequence played' do
            it 'winner returns X' do
                board = make_board_and_play_moves([1, 2, 4, 5, 7])
                expect(board.winner()).to eq('X')
            end
        end
    end

    describe 'to_s' do
        context 'to_s called' do
            it 'returns string representation' do
                board = make_board_and_play_moves([7, 8, 5, 6])
                expect(board.to_s).to eq("---\n-XO\nXO-\n")
            end
        end
    end
end

def make_board_and_play_moves(moves)
    board = Board.new()
    play_moves(board, moves)
    board
end

def play_moves(board, moves)
    moves.each do |move|
        board.play(move)
    end
end
