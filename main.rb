# frozen_string_literal: true

# puts "   | x | o "
# puts "-----------"
# puts "   | x |   "
# puts "-----------"
# puts " x | o |   "

class TTT_Game
  attr_reader :board

  def initialize
    @board = Array.new(9, "   ")
    @turn_num = 0
    @horiz1 = [0, 1, 2]
    @horiz2 = [3, 4, 5]
    @horiz3 = [6, 7, 8]
    @vert1 = [0, 3, 6]
    @vert2 = [1, 4, 7]
    @vert3 = [2, 5, 8]
    @diag1 = [0, 4, 8]
    @diag2 = [2, 4, 6]
    @win_lines = [@horiz1, @horiz2, @horiz3, @vert1, @vert2, @vert3, @diag1, @diag2]
    @game_over = false
  end

  def show_board
    puts "#{board[0]}|#{board[1]}|#{board[2]}"
    puts "-----------"
    puts "#{board[3]}|#{board[4]}|#{board[5]}"
    puts "-----------"
    puts "#{board[6]}|#{board[7]}|#{board[8]}"
  end

  def start_game
    play_move until @game_over
  end

  def play_move
    puts "Please enter a integer from 0 to 8, with 0 being top left and 8 being bottom right."
    num = Integer(gets, exception: false)

    if !num || num < 0 || num > 8 # rubocop:disable Style/NumericPredicate
      puts "Not a valid integer."
    elsif @board[num] != "   "
      puts "Invalid entry, space already occupied"
    else
      @board[num] = (@turn_num % 2).even? ? " x " : " o "
      return if check_win?(num) == true

      @turn_num += 1
    end

    show_board
  end

  def check_win?(num)
    @win_lines.each do |line_indexes|
      next unless line_indexes.include?(num)

      win = true
      line_indexes.each do |index|
        win = false if @board[index] != @board[num]
      end

      next unless win

      @game_over = true
      puts "You win!"
      show_board
      return true
    end
    false
  end
end

game1 = TTT_Game.new
game1.start_game
