require 'move_requester'

class HumanPlayer
  def initialize(ui)
    @ui = ui
    @move_requester = MoveRequester.new(@ui)
  end
  
  def move(board)
    @move_requester.request(board)
  end
end
