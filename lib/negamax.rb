class Negamax
  WINNING_SCORE = 10
  LOSING_SCORE = -10

  def negamax(board)

    if board.game_over?
      return [nil, score(board)]
    end

    best_score = -1000000
    best_position = nil

    board.available_moves.map do |move|
      new_board = board.play(move)
      x = negamax(new_board)
      x[1] = -x[1]
      if x[1] > best_score
        best_score = x[1]
        best_position = move
      end
    end

    [best_position, best_score]
  end

  private

  def score(board)
    if board.tie?
      0
    elsif board.winner?(board.current_marker)
      WINNING_SCORE
    else
      LOSING_SCORE
    end
  end
end
