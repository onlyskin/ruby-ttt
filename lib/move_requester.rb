class MoveRequester
  def initialize(ui)
    @ui = ui
  end

  def request(board)
    @ui.output('Please choose a move:')
    result = @ui.input
    if !is_valid?(result, board)
      @ui.output('Please give valid input.')
      return request(board)
    end
    result.to_i
  end
  
  private

  def is_valid?(result, board)
    is_i?(result) && available?(result, board)
  end

  def available?(result, board)
    board.available_moves.include?(result.to_i)
  end

  def is_i?(string)
    string.to_i.to_s == string
  end
end
