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
      row.each_with_index do |square, column|
        (0..3).include?(row) ? color = :black : color = :red
        if row.even?
          self[[row, column]] = Piece.new(color, [row, column]) if index.odd?
        else
          self[[row, column]] = Piece.new(color, [row, column]) if index.even?
        end
      end
    end
  end

end
