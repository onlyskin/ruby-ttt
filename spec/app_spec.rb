require 'app'
require 'ui'

describe App do
  describe 'run' do
    context 'run app with hardcoded human/human game' do
      it 'prints boards out' do
        input = StringIO.new("1\n1\n2\n4\n5\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)

        app.run

        expect(output.string).to include('X', 'O', '1', '│', '└')
      end

      it 'prints start and end messages' do
        input = StringIO.new("1\n1\n2\n4\n5\n20\n7\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)

        app.run

        expect(output.string).to include('Welcome')
        expect(output.string).to include('Thanks')
      end

      it 'prints a game menu' do
        input = StringIO.new("2\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)

        app.run

        expect(output.string).to include('Play')
        expect(output.string).to include('Exit')
      end
    end
  end
end
