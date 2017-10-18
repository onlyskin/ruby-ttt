require_relative 'game'
require_relative 'minimax'
require_relative 'computer_player'
require_relative 'choice_requester'

# A class to manage the running of a game
class App
  def initialize(ui)
    @running = true
    @ui = ui
    @choice_requester = ChoiceRequester.new(ui)
    @MENU_CHOICES = {'Play' => self.method(:run_game),
                     'Exit' => self.method(:exit)}
  end

  def run
    @ui.output('Welcome to Tic Tac Toe')
    while @running
      menu
    end
  end

  private

  def menu
    @ui.clear
    choice = @choice_requester.request(@MENU_CHOICES.keys)
    @MENU_CHOICES.fetch(choice).call
  end

  def run_game
    players = [HumanPlayer.new(@ui), HumanPlayer.new(@ui)]
    game = Game.new(@ui, players)
    game.run
    @ui.output('Thanks for playing.')
  end

  def exit
    @running = false
  end
end
