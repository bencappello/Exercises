require_relative 'require_files'

class Board
  DIMENSIONS = 8

attr_writer :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def place_piece(color, pos, rank = :p)
    if rank == :k
      self[pos] = KingPiece.new(color, pos, self)
    else
      self[pos] = Piece.new(color, pos, self)
    end
  end

  def inspect
  end

  def dup
    duped_board = Board.new
    duped_board.grid = Array.new(8) {Array.new(8)}

    pieces.each do |piece|
      duped_board[piece.pos] = piece.dup
    end

    duped_board
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
    print " " + ("0".."7").to_a.join
    puts ""
    @grid.each_with_index do |row, index|
      print (index)
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

  def pieces
    @grid.flatten.compact
  end

end
