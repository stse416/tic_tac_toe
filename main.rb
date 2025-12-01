require "pry-byebug"

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
    puts "Please enter a integer from 1 to 9, with 1 being top left and 9 being bottom right."
    num = gets.chomp.to_i

    return unless valid_move?(num)

    num -= 1
    @board[num] = (@turn_num % 2).even? ? " x " : " o "
    return if check_win?(num) == true

    @turn_num += 1

    show_board
  end

  def valid_move?(num)
    if num < 1 || num > 9
      puts "Not a valid integer."
      return false
    elsif @board[num - 1] != "   "
      puts "Invalid entry, space already occupied"
      return false
    end
    true
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
