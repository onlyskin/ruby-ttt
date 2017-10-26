require 'web_app'
require 'rack'

describe WebApp do
  describe '#call' do
    context 'get' do
      it 'status code and content-type correct' do
        response = @mock_request.get('')
        expect(response.status).to eq(200)
        expect(response.get_header('Content-Type')).to eq('text/html')
      end

      it 'returns html with start button' do
        response = @mock_request.get('')
        expect(response.body).to match(/<form method="post" action="">/)
        expect(response.body).to match(/<input type="hidden".*name="start".*>/)
        expect(response.body).to match(/<button type="submit">/)
      end

      it 'doesnt set session cookie' do
        response = @mock_request.get('')
        expect(response.has_header?('session')).to be(false)
      end
    end

    context 'post with start=true' do
      it 'sets session cookie' do
        response = @mock_request.post('', :input => 'start=true')
        expect(response.get_header('session')).to eq('1')
      end

      it 'returns status code 200 and content-type' do
        response = @mock_request.post('', :input => 'start=true')
        expect(response.status).to eq(200)
        expect(response.get_header('Content-Type')).to eq('text/html')
      end

      it 'returns html with buttons with empty cells' do
        response = @mock_request.post('', :input => 'start=true')
        expect(response.body).to match(/<form method="post" action=""/)
        expect(response.body).to match(/<input type="hidden" name="cell" value="9"/)
        expect(response.body).to match(/<button class="board-cell" type="submit"><\/button>/)
        expect(response.body).to match(/<button type="submit">/)
        expect(response.body).to match(/<input type="hidden".*name="reset".*>/)
      end
    end
    
    context 'post with cell data' do
      it 'returns html board with played in cells' do
        response = @mock_request.post('', :input => 'cell=1')
        expect(response.body).to match(/button class="board-cell" type="submit">X<\/button>/)
        expect(response.body).to match(/button class="board-cell" type="submit">O<\/button>/)
      end
    end

    context 'post with cell data that ends the game' do
      it 'says who the winner is in the page' do
        minimax = instance_double('Minimax')
        allow(minimax).to receive(:minimax)
          .and_return([5, nil], [4, nil], [2, nil], [9, nil])
        web_game = WebGame.new(ComputerPlayer.new(minimax))
        web_game.play(1)
        web_game.play(7)
        web_game.play(6)
        web_game.play(8)
        web_app = WebApp.new(web_game)
        response = Rack::MockRequest.new(web_app).post('', :input => 'cell=3')
        expect(response.body).to match(/<h1>.*tie.*<\/h1>/)
      end

      it 'says that it is a tie in the page' do
        minimax = instance_double('Minimax')
        allow(minimax).to receive(:minimax)
          .and_return([2, nil], [5, nil])
        web_game = WebGame.new(ComputerPlayer.new(minimax))
        web_game.play(1)
        web_game.play(4)
        web_app = WebApp.new(web_game)
        response = Rack::MockRequest.new(web_app).post('', :input => 'cell=7')
        expect(response.body).to match(/<h1>.*X.*won.*<\/h1>/)
      end
    end

    context 'post with reset' do
      it 'sets new session cookie' do
        response = @mock_request.post('', :input => 'start=true')
        expect(response.get_header('session')).to eq('1')
        response = @mock_request.post('', :input => 'reset=true')
        expect(response.get_header('session')).to eq('2')
      end
    end

    context 'post with no data' do
      it 'returns 404' do
        response = @mock_request.post('')
        expect(response.status).to eq(404)
      end
    end
  end

  before(:each) do
    minimax = instance_double('Minimax')
    allow(minimax).to receive(:minimax)
      .and_return([2, nil], [5, nil])
    web_game = WebGame.new(ComputerPlayer.new(minimax))
    web_app = WebApp.new(web_game)
    @mock_request = Rack::MockRequest.new(web_app)
  end
end
