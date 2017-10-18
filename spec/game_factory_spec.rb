require 'game_factory'
require 'game'
require 'ui'

describe GameFactory do
  def ui_and_game_from_input(input)
      game_class = class_double('Game')
      allow(game_class).to receive(:new)
      choice_hash = {'Human' => :human_player,
        'Computer' => :computer_player}
      input = StringIO.new(input)
      output = StringIO.new
      ui = Ui.new(input, output)
      GameFactory.from_input(ui, game_class, choice_hash)
      [ui, game_class]
  end
  describe 'from_input' do
    it 'calls initialize on Game' do
      ui, game_class = ui_and_game_from_input("1\n1\n")
      expect(game_class).to have_received(:new)
    end
    
    it 'inits game with two human_players' do
      ui, game_class = ui_and_game_from_input("1\n1\n")
      expect(game_class).to have_received(:new).with(ui, [:human_player, :human_player])
    end

    it 'inits game with two computer players' do
      ui, game_class = ui_and_game_from_input("2\n2\n")
      expect(game_class).to have_received(:new).with(ui, [:computer_player, :computer_player])
    end

    it 'inits game with one human one computer player' do
      ui, game_class = ui_and_game_from_input("1\n2\n")
      expect(game_class).to have_received(:new).with(ui, [:human_player, :computer_player])
    end
  end
end
