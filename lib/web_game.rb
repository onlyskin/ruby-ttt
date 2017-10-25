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
    computer_move = @computer_player.move(@board)
    @board = @board.play(computer_move)
  end

  private

  def _cell_format(cell)
    if cell == '-'
      return ''
    end
    cell
  end

end
