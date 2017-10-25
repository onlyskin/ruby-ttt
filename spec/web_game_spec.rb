require 'web_game'
require 'computer_player'

describe WebGame do
  describe '#board_matrix and play' do
    it '1-9 matrix at start' do
      web_game = web_game_with_moves([], [5])
      expect(web_game.board_matrix).to eq([['', '', ''], ['', '', ''], ['', '', '']])
    end
    it 'X in 3, O in 5 after playing in cell' do
      web_game = web_game_with_moves([3], [5, 4, 2, 9])
      expect(web_game.board_matrix).to eq([['', '', 'X'], ['', 'O', ''], ['', '', '']])
    end
    it 'computer player doesnt play if game over' do
      web_game = web_game_with_moves([1, 7, 6, 8, 3], [5, 4, 2, 9])
      expect(web_game.board_matrix).to eq([['X', 'O', 'X'], ['O', 'O', 'X'], ['X', 'X', 'O']])
    end
  end

  describe 'game_state' do
    it 'returns empty string when game not over' do
      web_game = web_game_with_moves([3], [5])
      expect(web_game.game_state).to eq('')
    end
    
    it 'returns tie when the game is a tie' do
      web_game = web_game_with_moves([1, 7, 6, 8, 3], [5, 4, 2, 9])
      expect(web_game.game_state).to match(/tie/)
    end
    
    it 'returns winner when there is a winner' do
      web_game = web_game_with_moves([1, 4, 7], [2, 5])
      expect(web_game.game_state).to match(/X.*won/)
    end
  end

  def web_game_with_moves(moves, computer_moves)
      computer_player = instance_double('ComputerPlayer')
      allow(computer_player).to receive(:move)
        .and_return(*computer_moves)
      web_game = WebGame.new(computer_player)
      moves.map do |move|
        web_game.play(move)
      end
      web_game
  end
end
