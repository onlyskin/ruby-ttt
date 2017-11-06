require 'session_manager'
require 'web_app'
require 'web_game_factory'
require 'rack'

describe WebApp do
  before(:each) do
    @session_manager = instance_double('SessionManager',
      :new_game => nil,
      :game_state => [['', '', ''], ['', '', ''], ['', '', '']],
      :game_result => :game_result_string,
      :play => nil)
    web_app = WebApp.new(@session_manager)
    web_app = Rack::Session::Cookie.new(web_app, :secret => 'my_secret')
    @mock_request = Rack::MockRequest.new(web_app)
  end

  describe 'get request' do
    it 'returns status 200' do
      response = @mock_request.get('')
      expect(response.status).to eq(200)
      expect(response.get_header('Content-Type')).to eq('text/html')
    end

    it 'returns index page' do
      response = @mock_request.get('')
      expect(response.body).to match(/<h1>Welcome/)
    end
  end

  describe 'gets to start' do
    it 'returns status 200' do
      response = @mock_request.get('/start')
      expect(response.status).to eq(200)
      expect(response.get_header('Content-Type')).to eq('text/html')
    end

    it 'returns game page' do
      response = @mock_request.get('/start')
      expect(response.body).to match(/<button class="board-cell"/)
    end

    it 'calls SessionManager methods' do
      response = @mock_request.get('/start')
      expect(@session_manager).to have_received(:new_game)
      expect(@session_manager).to have_received(:game_state)
      expect(@session_manager).to have_received(:game_result)
    end
  end

  describe 'post to play' do
    it 'returns status 200' do
      response = @mock_request.post('/play')
      expect(response.status).to eq(200)
      expect(response.get_header('Content-Type')).to eq('text/html')
    end

    it 'returns game page' do
      response = @mock_request.post('/play')
      expect(response.body).to match(/<button class="board-cell"/)
    end

    it 'calls play on the session manager' do
      response = @mock_request.post('/play', :input => "cell=8")
      expect(@session_manager).to have_received(:play)
    end

    it 'calls SessionManager methods' do
      response = @mock_request.post('/play')
      expect(@session_manager).to have_received(:game_state)
      expect(@session_manager).to have_received(:game_result)
    end
  end

  describe 'post to other' do
    it 'returns status 404' do
      response = @mock_request.get('/invalid')
      expect(response.status).to eq(404)
    end

    it 'returns content-type html' do
      response = @mock_request.post('/invalid')
      expect(response.get_header('Content-Type')).to eq('text/html')
    end
    
    it 'returns html' do
      response = @mock_request.get('/invalid')
      expect(response.body).to match(/Invalid/)
    end
  end
end
