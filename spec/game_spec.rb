require_relative "../lib/game"

describe Game do
  describe "#start_game" do
    context "When game is over" do
      subject(:game_finished) { described_class.new }

      it "does not call #play_move" do
        game_finished.instance_variable_set(:@game_over, true)
        expect(game_finished).not_to receive(:play_move)
        game_finished.start_game
      end
    end

    context "When playing and winning" do
      subject(:win_game) { described_class.new }

      before do
        allow(win_game).to receive(:gets).and_return("1", "5", "2", "9", "3")
      end

      it "ends the game" do
        win_game.start_game

        game_over = win_game.instance_variable_get(:@game_over)
        expect(game_over).to be true
      end
    end
  end

  describe "#play_move" do
    context "playing a valid move" do
      subject(:move) { described_class.new }
      let(:board) { double(Board.new) }

      before do
        move.instance_variable_set(:@game_board, board)
        allow(move).to receive(:gets).and_return("1")
        allow(board).to receive(:valid_move?).and_return(true)
        allow(board).to receive(:board).and_return(" x ")
        allow(board).to receive(:show_board)
        allow(board).to receive(:check_win?).and_return(true)
      end

      it "calls the proper methods" do
        expect(board).to receive(:valid_move?).once
        expect(board).to receive(:board).once
        expect(board).to receive(:show_board).once
        expect(board).to receive(:check_win?).once
        move.play_move
      end

      it "increments the turn" do
        move.play_move
        turn = move.instance_variable_get(:@turn_num)
        expect(turn).to eq 1
      end
    end

    context "playing an invalid move" do
      subject(:invalid) { described_class.new }
      let(:board) { double(Board.new) }

      before do
        invalid.instance_variable_set(:@game_board, board)
        allow(invalid).to receive(:gets).and_return("g")
        allow(board).to receive(:valid_move?).and_return(false)
        allow(board).to receive(:board)
        allow(board).to receive(:show_board)
        allow(board).to receive(:check_win?)
      end

      it "does not progress game state" do
        expect(board).to receive(:valid_move?).once
        expect(board).not_to receive(:board)
        expect(board).not_to receive(:show_board)
        expect(board).not_to receive(:check_win?)
        invalid.play_move
        turn = invalid.instance_variable_get(:@turn_num)
        expect(turn).to eql 0
      end
    end

    context "first turn" do
      subject(:play_o) { described_class.new }

      before do
        allow(play_o).to receive(:gets).and_return("5")
      end

      it "plays an 'x' on odd numbered turns on the correct space" do
        play_o.play_move
        board = play_o.instance_variable_get(:@game_board)
        array_pos_four = board.instance_variable_get(:@board)[4]
        expect(array_pos_four).to eql(" x ")
      end
    end

    context "second turn" do
      subject(:play_x) { described_class.new }

      before do
        allow(play_x).to receive(:gets).and_return("2")
        play_x.instance_variable_set(:@turn_num, 1)
      end

      it "plays an 'o' on even numbered turns on the correct space" do
        play_x.play_move
        board = play_x.instance_variable_get(:@game_board)
        array_pos_one = board.instance_variable_get(:@board)[1]
        expect(array_pos_one).to eql(" o ")
      end
    end

    context "When resulting in a draw" do
      subject(:last_turn) { described_class.new }

      before do
        allow(last_turn).to receive(:gets).and_return("2")
        last_turn.instance_variable_set(:@turn_num, 8)
      end

      it "plays the 9th(final) move and ends the game" do
        last_turn.play_move
        turn = last_turn.instance_variable_get(:@turn_num)
        game_over = last_turn.instance_variable_get(:@game_over)
        expect(turn).to eql(9)
        expect(game_over).to be true
      end
    end
  end
end
