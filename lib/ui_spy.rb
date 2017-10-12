class UiSpy < Ui
  attr_reader :output_called_count

  def initialize(input, output)
    super(input, output)
    @output_called_count = 0
  end

  def output(string)
    super(string)
    @output_called_count += 1
  end
end
