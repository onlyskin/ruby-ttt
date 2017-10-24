require 'web_app'
require 'rack'

describe WebApp do
  describe '#call' do
    context 'get' do
      it 'returns status code 200' do
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'GET')
        response = web_app.call(env)
        expect(response[0]).to eq('200')
      end

      it 'returns correct content-type' do
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'GET')
        response = web_app.call(env)
        expect(response[1].key?('Content-Type')).to be(true)
        expect(response[1].fetch('Content-Type')).to eq('text/html')
      end

      it 'returns html with start button' do
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'GET')
        response = web_app.call(env)
        html = response[2].each.next
        expect(html).to match(/<form method="post" action="">/)
        expect(html).to match(/<input type="hidden".*name="start".*>/)
        expect(html).to match(/<button type="submit">/)
      end
    end

    context 'post with start=true' do
      it 'returns status code 200' do
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'POST', :input => 'start=true')
        response = web_app.call(env)
        req = Rack::MockRequest.new(env)
        expect(response[0]).to eq('200')
        expect(response[1].key?('Content-Type')).to be(true)
        expect(response[1].fetch('Content-Type')).to eq('text/html')
        html = response[2].each.next
        expect(html).to match(/<table>/)
        expect(html).to match(/<tr>.*<tr>.*<tr>/m)
      end
    end
    
    context 'post with no data' do
      it 'returns 404' do
        web_app = WebApp.new
        env = Rack::MockRequest.env_for('', 'REQUEST_METHOD' => 'POST')
        response = web_app.call(env)
        req = Rack::MockRequest.new(env)
        expect(response[0]).to eq('404')
      end
    end
  end

end
