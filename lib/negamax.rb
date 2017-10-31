class Negamax
  WINNING_SCORE = 1000
  LOSING_SCORE = -1000

  def negamax(board, marker = nil, depth = 0, alpha = -1000, beta = 1000, colour = 1)
    if marker.nil?
      marker = board.current_marker
    end

    if board.game_over?
      return [nil, colour * score(board, depth, marker)]
    end

    best_score = -1000000
    best_position = nil

    nodes = board.available_moves.map do |move|
      new_board = board.play(move)
      x = negamax(new_board, marker, depth + 1, -beta, -alpha, -colour)
      x[1] = -x[1]

      if x[1] > best_score
        best_score = x[1]
        best_position = move
      end
      alpha = [alpha, x[1]].max

      if alpha >= beta
        return [move, x[1]]
      end

      [move, x[1]]
    end

    best_by_score(nodes)
  end

  private

  def score(board, depth, marker)
    if board.tie?
      0
    elsif board.winner?(marker)
      WINNING_SCORE / depth
    else
      LOSING_SCORE / depth
    end
  end

  def best_by_score(nodes)
    nodes.max_by do |node|
      node[1]
    end
  end
end
