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
      new_score = -negamax(new_board, marker, depth + 1, -beta, -alpha, -colour)[1]

      if new_score > best_score
        best_score = new_score
        best_position = move
      end

      alpha = [alpha, new_score].max

      if alpha >= beta
        return [move, new_score]
      end

      [move, new_score]
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
