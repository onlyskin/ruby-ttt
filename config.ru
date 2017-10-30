require_relative 'lib/web_app'
require_relative 'lib/session_manager'
require_relative 'lib/computer_player'
require_relative 'lib/web_game_factory'
require_relative 'lib/minimax'
require_relative 'lib/id_generator'
use Rack::Reloader

computer_player = ComputerPlayer.new(Minimax.new)
web_game_factory = WebGameFactory.new
session_manager = SessionManager.new(web_game_factory, computer_player, IdGenerator.new)
web_app = WebApp.new(session_manager)
run web_app

