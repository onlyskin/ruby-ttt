require_relative 'lib/web_app'
use Rack::Reloader

web_game = WebGame.new(ComputerPlayer.new(Minimax.new))
web_app = WebApp.new(web_game)
run web_app

