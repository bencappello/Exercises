require_relative 'require_files'

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
        (0..3).include?(row) ? color = :black : color = :white
        if row.even?
          self[[row, column]] = Piece.new(color, [row, column], self) if column.odd?
        else
          self[[row, column]] = Piece.new(color, [row, column], self) if column.even?
        end
      end
    end
  end

  def render
    print " " + ("A".."H").to_a.join
    puts ""
    @grid.each_with_index do |row, index|
      print (index + 1)
      row.each do |square|
        case square
        when NilClass
          print "_"
        else
          print square.render
        end
      end
      puts ""
    end
    nil
  end

end
