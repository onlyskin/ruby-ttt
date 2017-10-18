require'choice_requester'
require 'ui'

describe ChoiceRequester do
  describe 'request' do
    it 'prints options out with indexes' do
      input = StringIO.new("2\n")
      output = StringIO.new
      ui = Ui.new(input, output)
      choice_requester = ChoiceRequester.new(ui)
      choice_requester.request(['ex1', 'ex2', 'ex3'])

      expect(output.string).to include('1) ex1')
      expect(output.string).to include('3) ex3')
    end

    it 'gets user input' do
      input = StringIO.new("2\n")
      output = StringIO.new
      ui = Ui.new(input, output)
      choice_requester = ChoiceRequester.new(ui)

      result = choice_requester.request(['ex1', 'ex2', 'ex3'])

      expect(result).to eq('ex2')
    end

    it 'rejects out of range input' do
      input = StringIO.new("6\n2\n")
      output = StringIO.new
      ui = Ui.new(input, output)
      choice_requester = ChoiceRequester.new(ui)

      result = choice_requester.request(['ex1', 'ex2', 'ex3'])

      expect(result).to eq('ex2')
    end

    it 'rejects non integer input' do
      input = StringIO.new("invalid\n2\n")
      output = StringIO.new
      ui = Ui.new(input, output)
      choice_requester = ChoiceRequester.new(ui)

      result = choice_requester.request(['ex1', 'ex2', 'ex3'])

      expect(result).to eq('ex2')
    end

    it 'prints error message on invalid input' do
      input = StringIO.new("invalid\n2\n")
      output = StringIO.new
      ui = Ui.new(input, output)
      choice_requester = ChoiceRequester.new(ui)

      result = choice_requester.request(['ex1', 'ex2', 'ex3'])

      expect(output.string).to include('valid')
    end
  end
end
