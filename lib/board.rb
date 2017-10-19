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

  def initialize(cells: 'no_cells_passed', size: 3)
    if cells == 'no_cells_passed'
      @cells = ['-'] * size * size
    else
      @cells = cells
    end
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
    PATHS.any? { |path| path.all? { |cell| @cells[cell] == marker } }
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
        if index > 9
          middle += "#{cell_s(index)} │"
        else
          middle += " #{cell_s(index)} │"
        end
      end
      if (n != size-1)
        middle += "\n│" + "───│"*(size)
      end
      middle
  end

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
