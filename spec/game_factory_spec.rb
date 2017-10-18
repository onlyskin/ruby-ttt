require 'game_factory'
require 'game'

describe GameFactory do
  describe 'from_input' do
    it 'calls initialize on Game' do
      game_class = class_double('Game')
      allow(game_class).to receive(:new)

      GameFactory.from_input(game_class)

      expect(game_class).to receive(:new)
    end
  end
end
