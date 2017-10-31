require 'id_generator'

describe 'IdGenerator' do
  describe 'id' do
    it 'returns a sequence' do
      id_generator = IdGenerator.new

      id = id_generator.id
      id2 = id_generator.id
      id3 = id_generator.id

      expect(id). to eq(1)
      expect(id2). to eq(2)
      expect(id3). to eq(3)
    end
  end
end
