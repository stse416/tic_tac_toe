require_relative "board"

class Game
  def initialize
    @game_board = Board.new
    @turn_num = 0
    @game_over = false
  end

  def start_game
    puts ""
    puts " 1 | 2 | 3 "
    puts "-----------"
    puts " 4 | 5 | 6 "
    puts "-----------"
    puts " 7 | 8 | 9 "
    puts ""
    puts "Playable spaces are entered by inputting a number from 1-9."
    puts "Once input, your symbol will be placed in the respective slot."
    puts "Player 1 is 'x'. Player 2 is 'o'"
    puts ""

    play_move until @game_over
  end

  def play_move
    if (@turn_num % 2).even?
      puts "Player 1('X') to move:"
    else
      puts "Player 2('O') to move:"
    end
    num = gets.chomp.to_i

    return unless @game_board.valid_move?(num)

    num -= 1
    @game_board.board[num] = (@turn_num % 2).even? ? " x " : " o "

    @turn_num += 1
    @game_board.show_board
    @game_over = true if @game_board.check_win?(num) == true

    return unless @turn_num > 8 && @game_over == false

    puts "Result: Draw"
    @game_over = true
  end
end
