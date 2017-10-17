# A class which updates and reports the state of the Board
class Board
  PATHS = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze
  MARKERS = %w[O X].freeze

  def initialize(cells = ['-', '-', '-', '-', '-', '-', '-', '-', '-'])
    @cells = cells
  end

  def available_moves
    @cells.map
          .with_index(1) { |cell, i| cell == '-' ? i : nil }
          .compact
  end

  def current_marker
    MARKERS[available_moves.length % 2]
  end

  def winner?(marker)
    PATHS.any? { |path| path.all? { |cell| @cells[cell] == marker } }
  end

  def tie?
    full? && !winner?('X') && !winner?('O')
  end

  def game_over?
    winner?('X') || winner?('O') || tie?
  end

  def winner
    if !game_over?
      raise Exception
    elsif winner?('X')
      'X'
    elsif winner?('O')
      'O'
    end
  end

  def play(move)
    cells = @cells.clone
    cells[move - 1] = current_marker
    Board.new(cells)
  end

  def to_s
    %(┌───┬───┬───┐
│ #{cell_s(1)} │ #{cell_s(2)} │ #{cell_s(3)} │
│───│───│───│
│ #{cell_s(4)} │ #{cell_s(5)} │ #{cell_s(6)} │
│───│───│───│
│ #{cell_s(7)} │ #{cell_s(8)} │ #{cell_s(9)} │
└───┴───┴───┘)
  end

  private

  def cell_s(index)
    if @cells[index - 1] == '-'
      index.to_s
    else
      @cells[index - 1]
    end
  end

  def full?
    available_moves.empty?
  end
end
