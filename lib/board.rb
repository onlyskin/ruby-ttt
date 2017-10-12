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
    @cells[move - 1] = current_marker
    Board.new(@cells)
  end

  def to_s
    result = ''
    (0..8).each do |i|
      result << @cells[i]
      if i % 3 == 2
        result << "\n"
      end
    end
    result
  end

  private

  def full?
    available_moves.empty?
  end
end
