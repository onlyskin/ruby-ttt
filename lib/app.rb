require_relative 'game'

# A class to manage the running of a game
class App
  def initialize(ui)
    @ui = ui
  end

  def run
    @ui.output('Welcome to Tic Tac Toe')
    game = Game.new(@ui)
    game.run
    @ui.output('Thanks for playing.')
  end
end
