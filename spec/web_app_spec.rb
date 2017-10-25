require 'web_app'
require 'rack'

describe WebApp do
  describe '#call' do
    context 'get' do
      it 'status code and content-type correct' do
        response = response_for_request('GET', '')
        expect(response[0]).to eq('200')
        expect(response[1].key?('Content-Type')).to be(true)
        expect(response[1].fetch('Content-Type')).to eq('text/html')
      end

      it 'returns html with start button' do
        html = response_for_request('GET', '')[2].each.next
        expect(html).to match(/<form method="post" action="">/)
        expect(html).to match(/<input type="hidden".*name="start".*>/)
        expect(html).to match(/<button type="submit">/)
      end
    end

    context 'post with start=true' do
      it 'returns status code 200 and content-type' do
        response = response_for_request('POST', 'start=true')
        expect(response[0]).to eq('200')
        expect(response[1].key?('Content-Type')).to be(true)
        expect(response[1].fetch('Content-Type')).to eq('text/html')
      end

      it 'returns html with buttons with empty cells' do
        response = response_for_request('POST', 'start=true')
        html = response[2].each.next
        expect(html).to match(/<form method="post" action=""/)
        expect(html).to match(/<input type="hidden" name="cell" value="9"/)
        expect(html).to match(/<button class="board-cell" type="submit"><\/button>/)
        expect(html).to match(/<button type="submit">/)
        expect(html).to match(/<input type="hidden".*name="reset".*>/)
      end
    end
    
    context 'post with cell data' do
      it 'returns html board with played in cells' do
        response = response_for_request('POST', 'cell=1')
        html = response[2].each.next
        expect(html).to match(/button class="board-cell" type="submit">X<\/button>/)
        expect(html).to match(/button class="board-cell" type="submit">O<\/button>/)
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
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'POST', :input => 'cell=3')
        response = web_app.call(env)
        html = response[2].each.next
        expect(html).to match(/<h1>.*tie.*<\/h1>/)
      end

      it 'says that it is a tie in the page' do
        minimax = instance_double('Minimax')
        allow(minimax).to receive(:minimax)
          .and_return([2, nil], [5, nil])
        web_game = WebGame.new(ComputerPlayer.new(minimax))
        web_game.play(1)
        web_game.play(4)
        web_app = WebApp.new(web_game)
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'POST', :input => 'cell=7')
        response = web_app.call(env)
        html = response[2].each.next
        expect(html).to match(/<h1>.*X.*won.*<\/h1>/)
      end
    end

    context 'post with reset' do
      it 'returns html with buttons with empty cells' do
        response = response_for_request('POST', 'reset=true')
        html = response[2].each.next
        expect(html).to match(/<form method="post" action=""/)
        expect(html).to match(/<input type="hidden" name="cell" value="9"/)
        expect(html).to match(/<button class="board-cell" type="submit"><\/button>/)
        expect(html).to match(/<button type="submit">/)
        expect(html).to match(/<input type="hidden".*name="reset".*>/)
      end
    end

    context 'post with no data' do
      it 'returns 404' do
        response = response_for_request('POST', '')
        expect(response[0]).to eq('404')
      end
    end
  end

  def response_for_request(method, data)
        minimax = instance_double('Minimax')
        allow(minimax).to receive(:minimax)
          .and_return([2, nil], [5, nil])
        web_game = WebGame.new(ComputerPlayer.new(minimax))
        web_app = WebApp.new(web_game)
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => method, :input => data)
        response = web_app.call(env)
        response
  end
end
