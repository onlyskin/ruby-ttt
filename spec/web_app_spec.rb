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
        expect(html).to match(/<input type="hidden" name="x" value=/)
        expect(html).to match(/<input type="hidden" name="y" value=/)
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
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => method, :input => data)
        response = web_app.call(env)
        response
  end
end
