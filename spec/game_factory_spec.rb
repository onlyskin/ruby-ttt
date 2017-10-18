require 'game_factory'
require 'game'
require 'ui'

describe GameFactory do
  def Game_from_input(input)
      game_class = class_double('Game')
      allow(game_class).to receive(:new)
      choice_hash = {'Human' => :human_player,
        'Computer' => :computer_player}
      input = StringIO.new(input)
      output = StringIO.new
      ui = Ui.new(input, output)
      GameFactory.from_input(ui, game_class, choice_hash)
      game_class
  end
  describe 'from_input' do
    it 'calls initialize on Game' do
      game_class = Game_from_input("1\n1\n")
      expect(game_class).to have_received(:new)
    end
    
    it 'inits game with two human_players' do
      game_class = Game_from_input("1\n1\n")
      expect(game_class).to have_received(:new).with(:human_player, :human_player)
    end

    it 'inits game with two computer players' do
      game_class = Game_from_input("2\n2\n")
      expect(game_class).to have_received(:new).with(:computer_player, :computer_player)
    end

    it 'inits game with one human one computer player' do
      game_class = Game_from_input("1\n2\n")
      expect(game_class).to have_received(:new).with(:human_player, :computer_player)
    end
  end
end
