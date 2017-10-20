require_relative 'choice_requester'
require_relative 'game'

class GameFactory
  def self.from_input(ui, choice_hash, board_size: 3)
    choices = self.player_choices(ui, choice_hash)
    players = choices.map do |choice|
      self.choice_to_object(choice_hash, choice)
    end
    Game.new(ui, players, board_size: board_size)
  end
  
  private

  def self.player_choices(ui, choice_hash)
    choice_requester = ChoiceRequester.new(ui)
    (1..2).each.map do |n|
      ui.output("Player #{n} type:")
      choice_requester.request(choice_hash.keys)
    end
  end

  def self.choice_to_object(choice_hash, choice)
    choice_hash.fetch(choice)
  end
end
