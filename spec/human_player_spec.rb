require 'human_player'
require 'ui'

describe HumanPlayer do
  before(:each) do
    @input = StringIO.new("3\n1\n")
    @output = StringIO.new
    @ui = Ui.new(@input, @output)
    @human_player = HumanPlayer.new(@ui)
    @board = instance_double('Board')
  end

  describe 'get_move' do
    it 'gets move from ui' do
        allow(@board).to receive(:available_moves)
                     .and_return([3])

        expect(@human_player.move(@board)).to eq(3)
    end

    it 'rejects unavailable move on board' do
        allow(@board).to receive(:available_moves)
                     .and_return([1])

        expect(@human_player.move(@board)).to eq(1)
    end
  end
end
