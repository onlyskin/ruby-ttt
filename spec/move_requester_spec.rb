require 'move_requester'

describe MoveRequester do
  before(:each) do
    @board = instance_double('Board')
    allow(@board).to receive(:available_moves).and_return([6])

    @ui = instance_double('Ui')
    allow(@ui).to receive(:output)

    @move_requester = MoveRequester.new(@ui)
  end

  context 'call request' do
    it 'outputs move request message' do
      set_ui_input(['6'])

      expect(@ui).to receive(:output).with(/move/)
      @move_requester.request(@board)
    end

    it 'gets user input from ui' do
      set_ui_input(['6'])

      expect(@ui).to receive(:input)
      expect(@move_requester.request(@board)).to eq(6)
    end

    it 'rejects string input' do
      set_ui_input(['invalid', 'still', '6'])

      expect(@move_requester.request(@board)).to eq(6)
    end

    it 'rejects unavailable move input' do
      set_ui_input(['100', '8', '6'])

      expect(@board).to receive(:available_moves)
      expect(@move_requester.request(@board)).to eq(6)
    end

    it 'outputs error message' do
      set_ui_input(['invalid', '6'])

      expect(@ui).to receive(:output).with(/valid input/)
      @move_requester.request(@board)
    end
  end

  def set_ui_input(values)
    allow(@ui).to receive(:input).and_return(*values)
  end
end
