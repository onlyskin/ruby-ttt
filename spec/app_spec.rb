require 'App'

describe App do
    describe 'output' do
        context 'call with string' do
            it 'puts to output' do
                input = StringIO.new("test input\n")
                output = StringIO.new()
                app = App.new(input, output)
                app.output('test output')
                expect(output.string).to eq("test output\n")
            end
        end
    end
    describe 'input' do
        context 'call' do
            it 'gets input' do
                input = StringIO.new("test input\n")
                output = StringIO.new()
                app = App.new(input, output)
                expect(app.input).to eq("test input")
            end
        end
    end
end
