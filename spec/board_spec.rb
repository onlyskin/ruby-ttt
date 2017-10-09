require "Board"

describe Board do
    describe ".example" do
        context "given no arguments" do
            it "returns zero" do
                expect(Board.example()).to eql(0)
            end
        end
    end
end
