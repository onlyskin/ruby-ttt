require 'Board'

describe Board do
    describe '[]' do
        context 'given new board, (3)' do
            it 'returns "-"' do
                board = Board.new()
                expect(board[3]).to eq("-")
            end
        end
    end

    describe '[]=' do
        context '(7, "X")' do
            it 'then [] returns "X" for (7)' do
                board = Board.new()
                board[7] = "X"
                expect(board[7]).to eq("X")
            end
        end
    end

    describe '#availableSpaces' do
        context 'given new board' do
            it 'returns array of 1 to 9' do
                board = Board.new() 
                expect(board.availableSpaces).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
            end
        end
    end
end
