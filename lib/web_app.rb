require_relative 'web_game'
require_relative 'computer_player'
require_relative 'minimax'

class WebApp
  def initialize(game)
    @session_generator = 0
    @game = game
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.get?
      return get_response(req)
    end
    if req.post?
      return post_response(req)
    end
  end

  private

  def post_response(req)
    if req.params == {}
      return ['404', {}, []]
    end

    handle_play(req)
    template = render_template
    response = Rack::Response.new(template, 200, {'Content-Type' => 'text/html'})
    handle_session(req, response)
    
    response
  end

  def handle_play(req)
    if req.params.key?('cell')
      @game.play(req.params['cell'].to_i)
    end
  end

  def render_template
    template = File.read('views/game.html.erb')
    matrix = @game.board_matrix
    game_state = @game.game_state
    ERB.new(template).result(binding)
  end

  def handle_session(req, response)
    if req.params.key?('start') || req.params.key?('reset')
      response.set_cookie('session_id', new_session_id)
    end
  end

  def get_response(req)
    template = File.read('views/index.html.erb')
    result = ERB.new(template).result(binding)
    Rack::Response.new(result, 200, {'Content-Type' => 'text/html'})
  end

  def new_session_id
    @session_generator = @session_generator + 1
    @session_generator.to_s
  end
end
