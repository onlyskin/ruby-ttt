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

      if req.params.key?('cell')
        @game.play(req.params['cell'].to_i)
      end

      template = File.read('views/game.html.erb')
      matrix = @game.board_matrix
      result = ERB.new(template).result(binding)
      response = Rack::Response.new(result, 200, {'Content-Type' => 'text/html'})
      if req.params.key?('start') || req.params.key?('reset')
        response.set_header('session', new_session_id)
      end
      response
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
