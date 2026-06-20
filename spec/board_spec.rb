require_relative "../lib/board"
require_relative "../lib/game"

describe Board do
  describe "#valid_move?" do
    subject(:board) { described_class.new }

    context "Given a valid move (num from 1-9)" do
      context "For an empty space" do
        it "returns true" do
          expect(board.valid_move?(4)).to be true
        end
      end

      context "Given an invalid space" do
        it "returns false" do
          expect(board.valid_move?(0)).to be false
        end
      end

      context "Given a non-empty space" do
        subject(:non_empty) { described_class.new(" X ") }
        it "returns false" do
          expect(non_empty.valid_move?(1)).to be false
        end
      end
    end
  end
end
