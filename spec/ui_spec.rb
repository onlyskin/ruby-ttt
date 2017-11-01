require 'ui'

describe Ui do
  before(:each) do
    input = StringIO.new("test input\n")
    @output = StringIO.new
    @ui = Ui.new(input, @output)
  end

  describe 'output' do
    it 'puts to output' do
      @ui.output('test output')

      expect(@output.string).to eq("test output\n")
    end
  end

  describe 'input' do
    it 'gets input' do
      expect(@ui.input).to eq('test input')
    end
  end

  describe 'clear' do
    it 'writes clearscreen char to output' do
      @ui.clear

      expect(@output.string).to eq("\e[H\e[2J")
    end
  end

  describe 'to_s' do
    it 'returns string representation when to_s called' do
      board = instance_double('Board',
        :cells => ['-', '-', '-', '-', 'X', 'O', 'X', 'O', '-'],
        :size => 3)

      @ui.output_board(board)

      expected = %(┌───┬───┬───┐
│ 1 │ 2 │ 3 │
│───│───│───│
│ 4 │ X │ O │
│───│───│───│
│ X │ O │ 9 │
└───┴───┴───┘)
      expect(@output.string).to eq(expected + "\n")
    end
    it 'returns 4x4 representation' do
      board = instance_double('Board',
        :cells => ['O', '-', '-', '-', '-', '-', '-', '-', '-', '-', 'X', '-', '-', '-', '-', '-'],
        :size => 4)

      @ui.output_board(board)

      expected = %(┌───┬───┬───┬───┐
│ O │ 2 │ 3 │ 4 │
│───│───│───│───│
│ 5 │ 6 │ 7 │ 8 │
│───│───│───│───│
│ 9 │10 │ X │12 │
│───│───│───│───│
│13 │14 │15 │16 │
└───┴───┴───┴───┘)
      expect(@output.string).to eq(expected + "\n")
    end
  end
end
