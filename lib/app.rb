require_relative 'negamax'
require_relative 'game'
require_relative 'computer_player'
require_relative 'choice_requester'
require_relative 'game_factory'

# A class to manage the running of a game
class App
  def initialize(ui)
    @running = true
    @ui = ui
    @choice_requester = ChoiceRequester.new(ui)
    @MENU_CHOICES = {'Play 3x3' => Proc.new { run_game },
                     'Play 4x4' => Proc.new { run_game(board_size: 4) },
                     'Exit' => Proc.new { quit }}
    @PLAYER_CHOICES = {'Human' => HumanPlayer.new(ui),
                       'Computer' => ComputerPlayer.new(Negamax.new)}
  end

  def run
    @ui.output('Welcome to Tic Tac Toe')
    while @running
      menu
    end
  end

  private

  def menu
    choice = @choice_requester.request(@MENU_CHOICES.keys)
    @MENU_CHOICES.fetch(choice).call
  end

  def run_game(board_size: 3)
    @ui.clear
    game = GameFactory.from_input(@ui, @PLAYER_CHOICES, board_size: board_size)
    game.run
    @ui.output('Thanks for playing.')
  end

  def quit
    @running = false
  end
end
