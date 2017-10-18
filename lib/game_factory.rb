require 'choice_requester'

class GameFactory
  def self.from_input(ui, game_class, choice_hash)
    choices = self.player_choices(ui, choice_hash)
    players = choices.map do |choice|
      self.choice_to_object(choice_hash, choice)
    end
    game_class.new(*players)
  end
  
  private

  def self.player_choices(ui, choice_hash)
    choice_requester = ChoiceRequester.new(ui)
    (1..2).each.map do |n|
      choice_requester.request(choice_hash.keys)
    end
  end

  def self.choice_to_object(choice_hash, choice)
    choice_hash.fetch(choice)
  end
end
