class ComputerPlayer
  def initialize(minimax)
    @minimax = minimax
  end
  
  def move(board)
    move = @minimax.minimax(board, nil, 0)
    move[0]
  end
end
