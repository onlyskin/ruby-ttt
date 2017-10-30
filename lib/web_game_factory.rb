require_relative 'web_game'

class WebGameFactory
  def make_game(computer_player)
    WebGame.new(computer_player)
  end
end
