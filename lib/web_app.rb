class WebApp
  def call(env)
    html = File.read('views/index.html.erb')
    ['200', {'Content-Type' => 'text/html'}, [html]]
  end
end
