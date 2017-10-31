class ComputerPlayer
  def initialize(negamax)
    @negamax = negamax
  end
  
  def move(board)
    move = @negamax.negamax(board)
    move[0]
  end
end
