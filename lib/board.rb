class Board
  attr_reader :board

  def initialize
    @board = Array.new(9, "   ")
    @horiz1 = [0, 1, 2]
    @horiz2 = [3, 4, 5]
    @horiz3 = [6, 7, 8]
    @vert1 = [0, 3, 6]
    @vert2 = [1, 4, 7]
    @vert3 = [2, 5, 8]
    @diag1 = [0, 4, 8]
    @diag2 = [2, 4, 6]
    @win_lines = [@horiz1, @horiz2, @horiz3, @vert1, @vert2, @vert3, @diag1, @diag2]
  end

  def show_board
    puts ""
    puts "#{board[0]}|#{board[1]}|#{board[2]}"
    puts "-----------"
    puts "#{board[3]}|#{board[4]}|#{board[5]}"
    puts "-----------"
    puts "#{board[6]}|#{board[7]}|#{board[8]}"
    puts ""
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

      puts "You win!"
      return true
    end
    false
  end
end
