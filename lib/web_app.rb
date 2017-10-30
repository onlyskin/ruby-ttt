class WebApp
  def initialize(session_manager)
    @session_manager = session_manager
  end

  def call(env)
    path_info = env.fetch('PATH_INFO')
    if path_info == '/'
      index_route
    elsif path_info == '/start'
      start_route
    elsif path_info == '/play'
      play_route(env)
    end
  end

  private

  def index_route
    template = File.read('views/index.html.erb')
    html = ERB.new(template).result(binding)
    Rack::Response.new(html, 200, {'Content-Type' => 'text/html'})
  end

  def start_route
    game_id = @session_manager.new_game_id
    html = render_game_template(game_id)
    response = Rack::Response.new(html, 200, {'Content-Type' => 'text/html'})
    response.set_cookie('session_id', game_id)
    return response
  end

  def play_route(env)
    req = Rack::Request.new(env)
    game_id = req.cookies['session_id']
    move = req.params['cell'].to_i
    @session_manager.play(game_id.to_i, move)
    html = render_game_template(game_id)
    response = Rack::Response.new(html, 200, {'Content-Type' => 'text/html'})
    response.set_cookie('session_id', game_id)
    return response
  end

  def render_game_template(game_id)
    game_result = @session_manager.game_result(game_id.to_i)
    matrix = @session_manager.game_state(game_id.to_i)
    template = File.read('views/game.html.erb')
    ERB.new(template).result(binding)
  end
end
