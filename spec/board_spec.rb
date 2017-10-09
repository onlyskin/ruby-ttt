require 'Board'

describe Board do
    describe 'availableMoves' do
        context 'after calling #play(1)' do
            it '1 is unavailable' do
                board = Board.new()
                board.play(1)
                expect(board.availableMoves).to eq([2, 3, 4, 5, 6, 7, 8, 9])
            end
        end
        context 'after calling #play(2)' do
            it '2 is unavailable' do
                board = Board.new()
                board.play(2)
                expect(board.availableMoves).to eq([1, 3, 4, 5, 6, 7, 8, 9])
            end
        end
    end

    describe 'currentMarker' do
        context 'at start'do
            it 'is X' do
                board = Board.new()
                expect(board.currentMarker).to eq('X')
            end
        end
        context 'after one turn' do
            it 'is O' do
                board = Board.new()
                board.play(1)
                expect(board.currentMarker).to eq('O')
            end
        end
    end
end
