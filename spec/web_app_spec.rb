require 'web_app'

describe WebApp do
  env = nil

  describe '#call' do
    it 'returns status code 200' do
      web_app = WebApp.new
      response = web_app.call(env)
      expect(response[0]).to eq('200')
    end

    it 'returns correct content-type' do
      web_app = WebApp.new
      response = web_app.call(env)
      expect(response[1].key?('Content-Type')).to be(true)
      expect(response[1].fetch('Content-Type')).to eq('text/html')
    end

    it 'returns html with start button' do
      web_app = WebApp.new
      response = web_app.call(env)
      html = response[2].each.next
      expect(html).to match(/<form method="post" action="">/)
      expect(html).to match(/<input type="hidden".*name="start".*>/)
      expect(html).to match(/<button type="submit">/)
    end
  end
end
