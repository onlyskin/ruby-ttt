require 'session_manager'
require 'web_app'
require 'web_game_factory'
require 'id_generator'
require 'rack'

describe WebApp do
  before(:each) do
    @session_manager = instance_double('SessionManager',
      :new_game_id => 3,
      :game_state => [['', '', ''], ['', '', ''], ['', '', '']],
      :game_result => :game_result_string,
      :play => nil)
    web_app = WebApp.new(@session_manager)
    @mock_request = Rack::MockRequest.new(web_app)
  end

  describe 'get request' do
    it 'returns status 200' do
      response = @mock_request.get('')
      expect(response.status).to eq(200)
    end

    it 'returns content-type html' do
      response = @mock_request.get('')
      expect(response.get_header('Content-Type')).to eq('text/html')
    end

    it 'returns index page' do
      response = @mock_request.get('')
      expect(response.body).to match(/<h1>Welcome/)
    end
  end

  describe 'post to start' do
    it 'returns status 200' do
      response = @mock_request.post('/start')
      expect(response.status).to eq(200)
    end

    it 'returns content-type html' do
      response = @mock_request.post('/start')
      expect(response.get_header('Content-Type')).to eq('text/html')
    end
    
    it 'returns game page' do
      response = @mock_request.post('/start')
      expect(response.body).to match(/<button class="board-cell"/)
    end

    it 'calls SessionManager#new_game_id' do
      response = @mock_request.post('/start')
      expect(@session_manager).to have_received(:new_game_id)
    end

    it 'sets session cookie to new_game_id' do
      response = @mock_request.post('/start')
      expect(response.get_header('Set-Cookie')).to eq('session_id=3')
    end

    it 'calls SessionManager#game_state' do
      response = @mock_request.post('/start')
      expect(@session_manager).to have_received(:game_state).with(3)
    end

    it 'calls SessionManager#game_result' do
      response = @mock_request.post('/start')
      expect(@session_manager).to have_received(:game_result).with(3)
    end
  end

  describe 'post to play' do
    it 'returns status 200' do
      response = @mock_request.post('/play')
      expect(response.status).to eq(200)
    end

    it 'returns content-type html' do
      response = @mock_request.post('/play')
      expect(response.get_header('Content-Type')).to eq('text/html')
    end
    
    it 'returns game page' do
      response = @mock_request.post('/play')
      expect(response.body).to match(/<button class="board-cell"/)
    end

    it 'returns the same cookie it received' do
      response = @mock_request.post('/play', 'HTTP_COOKIE' => 'session_id=1')
      expect(response.get_header('Set-Cookie')).to eq('session_id=1')
    end

    it 'calls play on the session manager with the game id from the cookie and the move from the post data' do
      response = @mock_request.post('/play', 'HTTP_COOKIE' => 'session_id=4', :input => "cell=8")
      expect(@session_manager).to have_received(:play).with(4, 8)
    end

    it 'calls SessionManager#game_state' do
      response = @mock_request.post('/play', 'HTTP_COOKIE' => 'session_id=3')
      expect(@session_manager).to have_received(:game_state).with(3)
    end

    it 'calls SessionManager#game_result' do
      response = @mock_request.post('/play', 'HTTP_COOKIE' => 'session_id=3')
      expect(@session_manager).to have_received(:game_result).with(3)
    end
  end
end
