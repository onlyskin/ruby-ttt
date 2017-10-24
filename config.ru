require_relative 'lib/web_app'
use Rack::Reloader

web_app = WebApp.new
run web_app

