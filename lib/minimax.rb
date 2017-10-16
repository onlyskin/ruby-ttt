class Minimax
  def minimax(board, marker, depth)
    marker = board.current_marker if marker.nil?

    if board.game_over?
      return [nil, score(board, marker)]
    end

    nodes = []

    board.available_moves.each do |move|
      new_board = board.play(move)
      best_move = minimax(new_board, marker, depth+1)
      best_move[0] = move
      nodes.push(best_move)
    end

    best_by_score(nodes, depth)
  end

  def best_by_score(nodes, depth)
    if depth % 2 == 0
      return nodes.max_by do |node|
        node[1]
      end
    else
      return nodes.min_by do |node|
        node[1]
      end
    end
  end

  def score(board, marker)
    if board.tie?
      return 0
    elsif board.winner?(marker)
      return 10
    else
      return -10
    end
  end
end
