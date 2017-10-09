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
end
