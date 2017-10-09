require 'Board'

describe Board do
    describe 'available_moves' do
        context 'after calling #play(1)' do
            it '1 is unavailable' do
                board = Board.new()
                board.play(1)
                expect(board.available_moves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
            end
        end
        context 'after calling #play(2)' do
            it '2 is unavailable' do
                board = Board.new()
                board.play(2)
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
                board = Board.new()
                board.play(1)
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
                board = Board.new()
                play_moves(board, [1, 2, 4, 5, 7])
                expect(board.winner).to eq('X')
            end
        end
        context 'O wins in centre column' do
            it 'returns O' do
                board = Board.new()
                play_moves(board, [1, 2, 3, 5, 6, 8])
                expect(board.winner).to eq('O')
            end
        end
        context 'X wins in right column' do
            it 'returns X' do
                board = Board.new()
                play_moves(board, [3, 2, 6, 5, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins in first row' do
            it 'returns X' do
                board = Board.new()
                play_moves(board, [1, 4, 2, 5, 3])
                expect(board.winner).to eq('X')
            end
        end
        context 'O wins in second row' do
            it 'returns O' do
                board = Board.new()
                play_moves(board, [1, 4, 8, 5, 9, 6])
                expect(board.winner).to eq('O')
            end
        end
        context 'X wins in third row' do
            it 'returns X' do
                board = Board.new()
                play_moves(board, [7, 4, 8, 5, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins on first diagonal' do
            it 'returns X' do
                board = Board.new()
                play_moves(board, [1, 2, 5, 3, 9])
                expect(board.winner).to eq('X')
            end
        end
        context 'X wins on second diagonal' do
            it 'returns X' do
                board = Board.new()
                play_moves(board, [7, 8, 5, 6, 3])
                expect(board.winner).to eq('X')
            end
        end
    end

    describe 'winner?' do
        context 'there is a winner' do
            it 'returns true' do
                board = Board.new()
                play_moves(board, [7, 8, 5, 6, 3])
                expect(board.winner?()).to be true
            end
        end
        context 'there is no winner' do
            it 'returns false' do
                board = Board.new()
                play_moves(board, [7, 8, 5, 6])
                expect(board.winner?()).to be false
            end
        end
    end
end

def play_moves(board, moves)
    moves.each do |move|
        board.play(move)
    end
end
