class ChoiceRequester
  def initialize(ui)
    @ui = ui
  end

  def request(options)
    output_options(options)
    choice = @ui.input
    if choice.to_i > options.length
      return request(options)
    end
    options[choice.to_i - 1]
  end

  private

  def output_options(options)
    options.each_with_index.map do |option, i|
      @ui.output("#{i + 1}) #{option}")
    end
  end
end
