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
end
