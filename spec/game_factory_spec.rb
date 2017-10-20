require 'game_factory'
require 'game'
require 'ui'

describe GameFactory do
  def ui_from_input(input, board_size: 3)
      allow(Game).to receive(:new)
      choice_hash = {'Human' => :human_player,
        'Computer' => :computer_player}
      ui = instance_double(Ui)
      allow(ui).to receive(:input).and_return(*input)
      allow(ui).to receive(:output)
      GameFactory.from_input(ui, choice_hash, board_size: board_size)
      ui
  end

  describe 'from_input' do
    it 'calls initialize on Game' do
      ui = ui_from_input(["1", "1"])
      expect(Game).to have_received(:new)
    end
    
    it 'inits 4x4 game' do
      ui = ui_from_input(["1", "1"], board_size: 4)
      expect(Game).to have_received(:new).with(ui, [:human_player, :human_player], {:board_size=>4})
    end

    it 'inits game with two human_players' do
      ui = ui_from_input(["1", "1"])
      expect(Game).to have_received(:new).with(ui, [:human_player, :human_player], {:board_size=>3})
    end

    it 'inits game with two computer players' do
      ui = ui_from_input(["2", "2"])
      expect(Game).to have_received(:new).with(ui, [:computer_player, :computer_player], {:board_size=>3})
    end

    it 'inits game with one human one computer player' do
      ui = ui_from_input(["1", "2"])
      expect(Game).to have_received(:new).with(ui, [:human_player, :computer_player], {:board_size=>3})
    end
    
    it 'ui receives output with "Player 1 type:" and "Player 2 type:"' do
      ui = ui_from_input(["1", "2"])
      expect(ui).to have_received(:output).with("Player 1 type:")
      expect(ui).to have_received(:output).with("Player 2 type:")
    end
  end
end
