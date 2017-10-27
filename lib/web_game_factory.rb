class WebGameFactory
  def make_game(computer_player)
    WebGame.new(computer_player)
  end
end
