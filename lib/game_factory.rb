class GameFactory
  def self.from_input(game_class)
    game_class.new(nil, nil)
  end
end
