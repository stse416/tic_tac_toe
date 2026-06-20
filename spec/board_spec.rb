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

      context "For a non-empty space" do
        subject(:non_empty) { described_class.new(" X ") }
        it "returns false" do
          expect(non_empty).to receive(:puts).with("Invalid entry, space already occupied")
          expect(non_empty.valid_move?(1)).to be false
        end
      end
    end

    context "Given an invalid space" do
      it "returns false" do
        expect(board).to receive(:puts).with("Not a valid integer.")
        expect(board.valid_move?(0)).to be false
      end
    end
  end

  describe "#check_win?" do
    context "Given no filled lines" do
      subject(:not_filled) { described_class.new("   ", "   ", "   ", "   ", " X ") }

      it "returns false" do
        expect(not_filled.check_win?(4)).to be false
      end
    end

    context "Given a filled but not winning" do
      context "horizontal line" do
        subject(:blocked_horiz) { described_class.new("   ", "   ", "   ", " O ", " X ", " O ") }

        it "it returns false" do
          expect(blocked_horiz.check_win?(5)).to be false
        end
      end

      context "vertical line" do
        subject(:blocked_vert) { described_class.new("   ", " O ", "   ", "   ", " X ", "   ", "   ", " X ", "   ") }

        it "returns false" do
          expect(blocked_vert.check_win?(1)).to be false
        end
      end

      context "diagonal line" do
        subject(:blocked_diag) { described_class.new("   ", "   ", " X ", "   ", " X ", "   ", " O ", "   ", "   ") }

        it "returns false" do
          expect(blocked_diag.check_win?(6)).to be false
        end
      end
    end

    context "Given a filled winning line" do
      subject(:winning_move) { described_class.new("   ", "   ", " X ", "   ", "   ", " X ", "   ", "   ", " X ") }
      it "it returns true" do
        expect(winning_move).to receive(:puts).with("You win!")
        expect(winning_move.check_win?(2)).to be true
      end
    end
  end
end
