require_relative 'lib/web_app'
require_relative 'lib/session_manager'
require_relative 'lib/computer_player'
require_relative 'lib/web_game_factory'
require_relative 'lib/negamax'

use Rack::Reloader
use Rack::Session::Cookie, :secret => 'my_secret'

computer_player = ComputerPlayer.new(Negamax.new)
web_game_factory = WebGameFactory.new
session_manager = SessionManager.new(web_game_factory, computer_player)
web_app = WebApp.new(session_manager)
run web_app

