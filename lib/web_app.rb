require_relative 'web_game'
require_relative 'computer_player'
require_relative 'minimax'

class WebApp
  def initialize(game)
    @game = game
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      if req.params == {}
        return ['404', {}, []]
      end
      if req.params.key?('cell')
        @game.play(req.params['cell'].to_i)
      end
      if req.params.key?('reset')
        @game = WebGame.new(ComputerPlayer.new(Minimax.new))
      end
      template = File.read('views/game.html.erb')
    else
      template = File.read('views/index.html.erb')
    end
    matrix = @game.board_matrix
    result = ERB.new(template).result(binding)
    ['200', {'Content-Type' => 'text/html'}, [result]]
  end
end
