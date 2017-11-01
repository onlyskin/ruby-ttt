require 'ui'

describe Ui do
  describe 'output' do
    it 'puts to output' do
      input = StringIO.new("test input\n")
      output = StringIO.new
      ui = Ui.new(input, output)

      ui.output('test output')

      expect(output.string).to eq("test output\n")
    end
  end

  describe 'input' do
    it 'gets input' do
      input = StringIO.new("test input\n")
      output = StringIO.new

      ui = Ui.new(input, output)

      expect(ui.input).to eq('test input')
    end
  end

  describe 'clear' do
    it 'writes clearscreen char to output' do
      input = StringIO.new("test input\n")
      output = StringIO.new
      ui = Ui.new(input, output)

      ui.clear

      expect(output.string).to eq("\e[H\e[2J")
    end
  end
end
