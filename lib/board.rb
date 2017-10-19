# A class which updates and reports the state of the Board
class Board
  MARKERS = %w[O X]

  def initialize(cells: 'no_cells_passed', size: 3)
    if cells == 'no_cells_passed'
      @cells = ['-'] * size * size
    else
      @cells = cells
    end

    rows = Array.new(size){|i| Array.new(size){|j| size*i+j } }
    columns = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
    @paths = columns + rows + [
      [0, 4, 8],
      [6, 4, 2]
    ]
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
    @paths.any? { |path| path.all? { |cell| @cells[cell] == marker } }
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
    Board.new(cells: cells)
  end

  def to_s
    top_s = "┌───" + "┬───"*(size-1) + "┐\n"
    bottom_s = '└───' + '┴───'*(size-1) + '┘'
    top_s + middle_s + bottom_s
  end

  private

  def size
    Math.sqrt(@cells.length)
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
        index = (n * size + m + 1).to_i
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
