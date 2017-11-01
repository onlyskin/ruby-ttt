class Board
  MARKERS = %w[O X]
  attr_reader :cells

  def initialize(cells: :no_cells_passed, size: 3)
    if cells == :no_cells_passed
      @cells = ['-'] * size * size
    else
      @cells = cells
    end

    @paths = paths(size)
  end

  def available_moves
    @cells.map
          .with_index(1) { |cell, i| cell == '-' ? i : nil }
          .compact
  end

  def current_marker
    MARKERS[(@cells.length - available_moves.length - 1) % 2]
  end

  def winner?(marker)
    @paths.any? do |path|
      path.all? do |cell|
        @cells[cell] == marker
      end
    end
  end

  def tie?
    full? && !winner?(MARKERS[1]) && !winner?(MARKERS[0])
  end

  def game_over?
    winner?(MARKERS[1]) || winner?(MARKERS[0]) || tie?
  end

  def winner
    if winner?(MARKERS[1])
      MARKERS[1]
    elsif winner?(MARKERS[0])
      MARKERS[0]
    end
  end

  def play(move)
    cells = @cells.clone
    cells[move - 1] = current_marker
    Board.new(cells: cells, size: size)
  end

  def to_matrix
    (0..size-1).each.map do |n|
      @cells[n*size..n*size+size-1]
    end
  end

  def size
    Math.sqrt(@cells.length).to_i
  end
  
  private

  def full?
    available_moves.empty?
  end

  def paths(size)
    rows = Array.new(size){|i| Array.new(size){|j| size*i+j } }
    columns = rows.transpose
    diagonal_1 = rows.map.with_index { |row, index| row[index] }
    diagonal_2 = rows.reverse.map.with_index { |row, index| row[index] }
    [*rows, *columns, diagonal_1, diagonal_2]
  end
end
