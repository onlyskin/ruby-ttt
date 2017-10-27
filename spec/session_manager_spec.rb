require 'session_manager'
require 'web_game_factory'
require 'computer_player'

describe SessionManager do
  describe 'start_game' do
    it 'calls make_game on web_game_factory' do
      web_game_factory = instance_double('WebGameFactory', :make_game => nil)
      session_manager = SessionManager.new(web_game_factory, nil)

      session_manager.start_game(5)

      expect(web_game_factory).to have_received(:make_game)
    end
  end

  describe 'game_state' do
    it 'returns result of board_matrix for web_game stored by id' do
      web_game = instance_double('WebGame',
        :board_matrix => :board_string_stub)
      web_game_factory = instance_double('WebGameFactory',
        :make_game => web_game)
      session_manager = SessionManager.new(web_game_factory, nil)

      session_manager.start_game(5)
      game_state = session_manager.game_state(5)

      expect(web_game).to have_received(:board_matrix)
      expect(game_state).to eq(:board_string_stub)
    end
  end

  describe 'play' do
    it 'calls play with the move on the appropriate game' do
      web_game = instance_double('WebGame', :play => nil)
      web_game_factory = instance_double('WebGameFactory',
        :make_game => web_game)
      session_manager = SessionManager.new(web_game_factory, nil)

      session_manager.start_game(4)
      session_manager.play(4, 5)

      expect(web_game).to have_received(:play).with(5)
    end
  end
end
