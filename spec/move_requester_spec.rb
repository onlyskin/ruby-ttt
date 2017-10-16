require 'move_requester'

describe MoveRequester do
  before(:each) do
    @board = instance_double('Board')
    allow(@board).to receive(:available_moves).and_return([6])
  end

  context 'call request' do
    it 'outputs move request message' do
      ui = instance_double('Ui')
      allow(ui).to receive(:input).and_return('6')
      allow(ui).to receive(:output)
      move_requester = MoveRequester.new(ui)
      expect(ui).to receive(:output).with(/move/)
      move_requester.request(@board)
    end
    it 'gets user input from ui' do
      ui = instance_double('Ui')
      allow(ui).to receive(:input).and_return('6')
      allow(ui).to receive(:output)
      move_requester = MoveRequester.new(ui)
      expect(ui).to receive(:input)
      expect(move_requester.request(@board)).to eq(6)
    end
    it 'rejects string input' do
      ui = instance_double('Ui')
      allow(ui).to receive(:input).and_return('invalid', 'still', '6')
      allow(ui).to receive(:output)
      move_requester = MoveRequester.new(ui)
      expect(move_requester.request(@board)).to eq(6)
    end
    it 'rejects unavailable move input' do
      ui = instance_double('Ui')
      allow(ui).to receive(:input).and_return('100', '8', '6')
      allow(ui).to receive(:output)
      move_requester = MoveRequester.new(ui)
      expect(@board).to receive(:available_moves)
      expect(move_requester.request(@board)).to eq(6)
    end
    it 'outputs error message' do
      ui = instance_double('Ui')
      allow(ui).to receive(:input).and_return('invalid', '6')
      allow(ui).to receive(:output)
      move_requester = MoveRequester.new(ui)
      expect(ui).to receive(:output).with(/valid input/)
      expect(move_requester.request(@board)).to eq(6)
    end
  end
end
