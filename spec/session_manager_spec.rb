require 'session_manager'
require 'id_generator'
require 'web_game_factory'
require 'computer_player'

describe SessionManager do
  before(:each) do
      @id_generator = instance_double('IdGenerator', :id => :id_result)
      @web_game = instance_double('WebGame',
        :board_matrix => :board_string_stub,
        :game_result => :game_result_string_stub,
        :play => nil)
      @web_game_factory = instance_double('WebGameFactory',
        :make_game => @web_game)
      @session_manager = SessionManager.new(@web_game_factory, nil, @id_generator)
  end

  describe 'start_game' do
    it 'calls make_game on web_game_factory' do
      id = @session_manager.new_game_id

      expect(@web_game_factory).to have_received(:make_game)
      expect(@id_generator).to have_received(:id)
      expect(id).to eq(:id_result)
    end
  end

  describe 'game_state' do
    it 'returns result of board_matrix for web_game stored by id' do
      id = @session_manager.new_game_id
      game_state = @session_manager.game_state(id)

      expect(@web_game).to have_received(:board_matrix)
      expect(game_state).to eq(:board_string_stub)
    end
  end

  describe 'game_result' do
    it 'returns result of game_state for web_game stored by id' do
      id = @session_manager.new_game_id
      game_result = @session_manager.game_result(id)

      expect(@web_game).to have_received(:game_result)
      expect(game_result).to eq(:game_result_string_stub)
    end
  end

  describe 'play' do
    it 'calls play with the move on the appropriate game' do
      id = @session_manager.new_game_id
      @session_manager.play(id, 5)

      expect(@web_game).to have_received(:play).with(5)
    end
  end
end
