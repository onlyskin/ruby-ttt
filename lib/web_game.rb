require_relative 'board'

class WebGame
  def initialize(computer_player)
    @board = Board.new
    @computer_player = computer_player
  end

  def board_matrix
    @board.to_matrix.map do |row|
      row.map do |cell|
        _cell_format(cell)
      end
    end
  end

  def play(move)
    @board = @board.play(move)
    if !game_over?
      computer_move = @computer_player.move(@board)
      @board = @board.play(computer_move)
    end
  end

  def game_over?
    @board.game_over?
  end

  def game_state
    if @board.game_over?
      if @board.tie?
        return 'The game was a tie.'
      end
      return "#{@board.winner} won the game."
    end
    ''
  end

  private

  def _cell_format(cell)
    if cell == '-'
      return ''
    end
    cell
  end

end
