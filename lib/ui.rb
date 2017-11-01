# A class to handle User input and output
class Ui
  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def output(string)
    @output.puts(string)
  end

  def input
    @input.gets.chomp
  end

  def clear
    @output.print("\e[H\e[2J")
  end

  def output_board(board)
    output(board_string(board))
  end
  
  private

  def board_string(board)
    top_s = "┌───" + "┬───"*(board.size-1) + "┐\n"
    bottom_s = '└───' + '┴───'*(board.size-1) + '┘'
    top_s + middle_s(board) + bottom_s
  end
  
  def middle_s(board)
    rows = (0..board.size-1).each.map do |n|
      row_s(board, n)
    end
    rows.join("\n") + "\n"
  end

  def row_s(board, n)
      middle = ""
      middle += "│"
      (0..board.size-1).each do |m|
        index = (n * board.size + m + 1)
        middle += "#{cell_s(board, index)}│"
      end
      if (n != board.size-1)
        middle += "\n│" + "───│"*(board.size)
      end
      middle
  end

  def cell_s(board, index)
    if board.cells[index - 1] == '-'
      if index > 9
        "#{index.to_s} "
      else
        " #{index.to_s} "
      end
    else
      " #{board.cells[index - 1]} "
    end
  end
end
