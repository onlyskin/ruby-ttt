require_relative 'web_game'
require_relative 'computer_player'
require_relative 'minimax'

class WebApp
  def initialize
    @game = WebGame.new(ComputerPlayer.new(Minimax.new))
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.post?
      if req.params == {}
        return ['404', {}, []]
      end
      matrix = @game.board_matrix
      template = File.read('views/game.html.erb')
    else
      template = File.read('views/index.html.erb')
    end
    result = ERB.new(template).result(binding)
    ['200', {'Content-Type' => 'text/html'}, [result]]
  end
end
