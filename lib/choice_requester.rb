class ChoiceRequester
  def initialize(ui)
    @ui = ui
  end

  def request(options)
    output_options(options)
    choice = @ui.input
    unless valid?(choice, options)
      @ui.output('Please give valid input.')
      return request(options)
    end
    options[choice.to_i - 1]
  end

  private

  def valid?(choice, options)
    in_range?(choice, options) && i?(choice)
  end

  def in_range?(choice, options)
    choice.to_i <= options.length
  end

  def i?(string)
    string.to_i.to_s == string
  end

  def output_options(options)
    options.each_with_index.map do |option, i|
      @ui.output("#{i + 1}) #{option}")
    end
  end
end
