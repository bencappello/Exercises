require_relative 'piece'

class Board
  DIMENSIONS = 8

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    starting_positions
  end

  def [](pos)
    row, column = pos
    @grid[row][column]
  end

  def []=(pos, piece)
    row, column = pos
    @grid[row][column] = piece
  end

  def starting_positions
    DIMENSIONS.times do |row|
      next if [3,4].include?(row)
      DIMENSIONS.times do |column|
        (0..3).include?(row) ? color = :black : color = :red
        if row.even?
          self[[row, column]] = Piece.new(color, [row, column]) if column.odd?
        else
          self[[row, column]] = Piece.new(color, [row, column]) if column.even?
        end
      end
    end
  end

end
