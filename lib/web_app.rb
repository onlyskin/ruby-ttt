class WebApp
  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      if req.params == {}
        return ['404', {}, []]
      end
      template = File.read('views/game.html.erb')
    else
      template = File.read('views/index.html.erb')
    end
    result = ERB.new(template).result(binding)
    ['200', {'Content-Type' => 'text/html'}, [result]]
  end
end
