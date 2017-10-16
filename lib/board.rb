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

  def play(move)
    cells = @cells.clone
    cells[move - 1] = current_marker
    Board.new(cells)
  end

  def to_s
    "┌───┬───┬───┐\n│ " +
    cellString(1) + " │ " +
    cellString(2) + " │ " +
    cellString(3) + " │\n│───│───│───│\n│ " +
    cellString(4) + " │ " +
    cellString(5) + " │ " +
    cellString(6) + " │\n│───│───│───│\n│ " +
    cellString(7) + " │ " +
    cellString(8) + " │ " +
    cellString(9) + " │\n└───┴───┴───┘";
  end

  private

  def cellString(index)
    if @cells[index-1] == '-'
      return index.to_s
    else
      return @cells[index-1]
    end
  end

  def full?
    available_moves.empty?
  end
end
