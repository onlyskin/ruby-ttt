class SessionManager
  def initialize(web_game_factory, computer_player, id_generator)
    @web_game_factory = web_game_factory
    @computer_player = computer_player
    @id_generator = id_generator
    @id_to_session = {}
  end

  def new_game_id()
    game = @web_game_factory.make_game(@computer_player)
    id = @id_generator.id
    @id_to_session[id] = game
    id
  end

  def game_state(id)
    retrieve_game(id).board_matrix
  end

  def play(id, move)
    retrieve_game(id).play(move)
  end

  private

  def retrieve_game(id)
    @id_to_session.fetch(id)
  end
end
