class ComputerPlayer
  def initialize(negamax)
    @negamax = negamax
  end
  
  def move(board)
    move = @negamax.negamax(board, nil, 0)
    move[0]
  end
end
