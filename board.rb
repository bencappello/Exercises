require_relative "pieces_require"

class Board

  attr_reader :grid

  def initialize
    generate
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def generate
    @grid = Array.new(8) {Array.new(8)}
    set_pawns
    set_other_pieces
  end

  def set_pawns
    @grid[1].each_with_index do |space, index|
      @grid[1][index] = Pawn.new(:b, [1, index], @grid)
    end

    @grid[6].each_with_index do |space, index|
      @grid[6][index] = Pawn.new(:w, [6, index], @grid)
    end
  end

  def set_other_pieces
    row = 0
    color = :b

    @grid[row].each_with_index do |space, column|
      if [0,7].include?(column)
        @grid[row][column] = Rook.new(color, [row, column], @grid)
      elsif [1,6].include?(column)
        @grid[row][column] = Knight.new(color, [row, column], @grid)
      elsif [2,5].include?(column)
        @grid[row][column] = Bishop.new(color, [row, column], @grid)
      elsif column == 3
        @grid[row][column] = Queen.new(color, [row, column], @grid)
      else #column == 4
        @grid[row][column] = King.new(color, [row, column], @grid)
      end
    end

    row = 7
    color = :w

    @grid[row].each_with_index do |space, column|
      if [0,7].include?(column)
        @grid[row][column] = Rook.new(color, [row, column], @grid)
      elsif [1,6].include?(column)
        @grid[row][column] = Knight.new(color, [row, column], @grid)
      elsif [2,5].include?(column)
        @grid[row][column] = Bishop.new(color, [row, column], @grid)
      elsif column == 3
        @grid[row][column] = Queen.new(color, [row, column], @grid)
      else #column == 4
        @grid[row][column] = King.new(color, [row, column], @grid)
      end
    end

  end


  def in_check?(color)
  end

  def move(start, final_pos)
  end

end
