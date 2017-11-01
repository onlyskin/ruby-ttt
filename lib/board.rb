class Board
  MARKERS = %w[O X]

  def initialize(cells: 'no_cells_passed', size: 3)
    if cells == 'no_cells_passed'
      @cells = ['-'] * size * size
    else
      @cells = cells
    end

    rows = Array.new(size){|i| Array.new(size){|j| size*i+j } }
    columns = rows.transpose
    diagonal_1 = rows.map.with_index { |row, index| row[index] }
    diagonal_2 = rows.reverse.map.with_index { |row, index| row[index] }
    @paths = [*rows, *columns, diagonal_1, diagonal_2]
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
    full? && !winner?('X') && !winner?('O')
  end

  def game_over?
    winner?('X') || winner?('O') || tie?
  end

  def winner
    if winner?('X')
      'X'
    elsif winner?('O')
      'O'
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

  def to_s
    top_s = "┌───" + "┬───"*(size-1) + "┐\n"
    bottom_s = '└───' + '┴───'*(size-1) + '┘'
    top_s + middle_s + bottom_s
  end

  private

  def size
    Math.sqrt(@cells.length).to_i
  end
  
  def middle_s
    rows = (0..size-1).each.map do |n|
      row_s(n)
    end
    rows.join("\n") + "\n"
  end

  def row_s(n)
      middle = ""
      middle += "│"
      (0..size-1).each do |m|
        index = (n * size + m + 1)
        middle += "#{cell_s(index)}│"
      end
      if (n != size-1)
        middle += "\n│" + "───│"*(size)
      end
      middle
  end

  def cell_s(index)
    if @cells[index - 1] == '-'
      if index > 9
        "#{index.to_s} "
      else
        " #{index.to_s} "
      end
    else
      " #{@cells[index - 1]} "
    end
  end

  def full?
    available_moves.empty?
  end
end
