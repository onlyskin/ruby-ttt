class Negamax
  def negamax(board, marker, depth)
    marker = board.current_marker if marker.nil?

    if board.game_over?
      return [nil, score(board, marker)]
    end

    best_score = -1000000
    best_position = nil

    board.available_moves.map do |move|
      new_board = board.play(move)
      x = negamax(new_board, marker, depth + 1)
      x[1] = -x[1]
      if x[1] > best_score
        best_score = x[1]
        best_position = move
      end
    end

    [best_position, best_score]
  end

  private

  def score(board, marker)
    if board.tie?
      0
    elsif board.winner?(board.current_marker)
      10
    else
      -10
    end
  end
end
