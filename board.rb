require_relative 'require_files'

class Board
  DIMENSIONS = 8

attr_writer :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
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

  # -----TEST PURPOSES ONLY. TO BE DELETED-------
  def place_piece(color, pos, rank = :p)
    if rank == :k
      self[pos] = KingPiece.new(color, pos, self)
    else
      self[pos] = Piece.new(color, pos, self)
    end
  end
  #---------------------------------------------

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
      print (index + 1)
      puts ""
    end
    puts " " + ("A".."H").to_a.join
    puts ""
    nil
  end

  def pieces
    @grid.flatten.compact
  end

  def black_pieces
    pieces.select { |piece| piece.color == :black }
  end

  def white_pieces
    pieces.select { |piece| piece.color == :white }
  end

end
