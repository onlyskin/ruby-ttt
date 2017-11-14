class WebApp
  def initialize(session_manager)
    @session_manager = session_manager
  end

  def call(env)
    path_info = env.fetch('PATH_INFO')
    if path_info == '/'
      index_route
    elsif path_info == '/start'
      start_route(env)
    elsif path_info == '/play'
      play_route(env)
    else
      invalid_route
    end
  end

  private

  def index_route
    template = File.read('views/index.html.erb')
    html = ERB.new(template).result(binding)
    [200, {'Content-Type' => 'text/html'}, [html]]
  end

  def start_route(env)
    env['rack.session']['init'] = true
    game_id = env['rack.session']['session_id']
    @session_manager.new_game(game_id)
    html = render_game_template(game_id)
    [200, {'Content-Type' => 'text/html'}, [html]]
  end

  def play_route(env)
    req = Rack::Request.new(env)
    env['rack.session']['init'] = true
    game_id = env['rack.session']['session_id']
    move = req.params['cell'].to_i
    @session_manager.play(game_id, move)
    html = render_game_template(game_id)
    [200, {'Content-Type' => 'text/html'}, [html]]
  end

  def render_game_template(game_id)
    game_result = @session_manager.game_result(game_id)
    matrix = @session_manager.game_state(game_id)
    template = File.read('views/game.html.erb')
    ERB.new(template).result(binding)
  end

  def invalid_route
    html = '<h1>404 - Invalid address</h1>'
    [404, {'Content-Type' => 'text/html'}, [html]]
  end
end
