require 'app'
require 'ui'

describe App do
  describe 'run' do
    def output_for_two_games
        input = StringIO.new("1\n1\n1\n1\n2\n4\n5\n7\n1\n1\n1\n1\n2\n4\n5\n7\n2\n")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)

        app.run
        output
    end

    context 'run app with human/computer game' do
      it 'runs game' do
        input = StringIO.new("1\n1\n2\n1\n7\n8\n2")
        output = StringIO.new
        ui = Ui.new(input, output)
        app = App.new(ui)

        app.run

        expect(output.string).to include('O won')
      end
    end

    context 'run app with hardcoded human/human game' do
      before(:each) do
        @output = output_for_two_games
      end
      it 'prints boards out' do
        expect(@output.string).to include('X', 'O', '1', '│', '└')
      end

      it 'prints start and end messages' do
        expect(@output.string).to include('Welcome')
        expect(@output.string).to include('Thanks')
      end

      it 'prints a game menu' do
        expect(@output.string).to include('Play')
        expect(@output.string).to include('Exit')
      end

      it 'plays two games in a row' do
        expect(@output.string).to match(/Play(.|\n)*Play/)
      end

      it 'clears when playing a new game' do
        ui = instance_double(Ui)
        allow(ui).to receive(:clear)
        allow(ui).to receive(:output)
        allow(ui).to receive(:input)
                 .and_return('1', '1', '2', '4', '5', '7', '2')
        app = App.new(ui)

        app.run

        expect(ui).to have_received(:clear).once
      end
    end
  end
end
