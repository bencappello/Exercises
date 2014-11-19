require_relative "pieces_require"

class Board

  attr_accessor :grid

  def initialize
    generate
    @taken_pieces = []
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, occupant)
    row, col = pos
    @grid[row][col] = occupant
  end

  def generate
    @grid = Array.new(8) {Array.new(8)}
    set_pawns
    set_other_pieces
  end

  def set_pawns
    @grid[1].each_with_index do |space, index|
      @grid[1][index] = Pawn.new(:b, [1, index], self)
    end

    @grid[6].each_with_index do |space, index|
      @grid[6][index] = Pawn.new(:w, [6, index], self)
    end
  end

  def set_other_pieces
    row = 0
    color = :b

    @grid[row].each_with_index do |space, column|
      if [0,7].include?(column)
        @grid[row][column] = Rook.new(color, [row, column], self)
      elsif [1,6].include?(column)
        @grid[row][column] = Knight.new(color, [row, column], self)
      elsif [2,5].include?(column)
        @grid[row][column] = Bishop.new(color, [row, column], self)
      elsif column == 3
        @grid[row][column] = Queen.new(color, [row, column], self)
      else #column == 4
        @grid[row][column] = King.new(color, [row, column], self)
      end
    end

    row = 7
    color = :w

    @grid[row].each_with_index do |space, column|
      if [0,7].include?(column)
        @grid[row][column] = Rook.new(color, [row, column], self)
      elsif [1,6].include?(column)
        @grid[row][column] = Knight.new(color, [row, column], self)
      elsif [2,5].include?(column)
        @grid[row][column] = Bishop.new(color, [row, column], self)
      elsif column == 3
        @grid[row][column] = Queen.new(color, [row, column], self)
      else #column == 4
        @grid[row][column] = King.new(color, [row, column], self)
      end
    end

  end

  def black_pieces
    pieces.select { |piece| piece.color == :b }
  end


  def pieces
    @grid.flatten.compact
  end

  def white_pieces
    pieces.select { |piece| piece.color == :w }
  end

  def king_position(colored_pieces)
    king = colored_pieces.select{|piece| piece.class == King}
    king.first.pos
  end

  #input black or white pieces
  def in_check?(color)
    if color == :w
      players_pieces, opposing_pieces = white_pieces, black_pieces
    else
      players_pieces, opposing_pieces = black_pieces, white_pieces
    end

    opposing_pieces.each do |piece|
      return true if piece.moves.include?(king_position(players_pieces))
    end
    false
  end

  def check_mate?(color)
    return false unless in_check?(color)
      if color == :w
        white_pieces.each do |piece|
          return false unless piece.moves.all? { |move| piece.move_into_check?(move) }
        end
        return true

      else
        black_pieces.each do |piece|
          return false unless piece.moves.all? { |move| piece.move_into_check?(move) }
        end
        return true
      end
  end

  # def stale_mate?
  #   #the same as check_mate? except the player isn't in check at the time
  # end

  def move(start, final_pos)
    raise "There is no piece at that start position" if self[start] == nil
    raise "You can't move there." unless self[start].moves.include?(final_pos)
    raise "You cannot put yourself in check" if self[start].move_into_check?(final_pos)

    @taken_pieces << self[final_pos] if self[final_pos]
    make_move(start, final_pos)
  end

  def make_move(start, final_pos)
    #update obj
    self[start].pos = final_pos

    #update the grid
    self[final_pos] = self[start]
    self[start] = nil
  end

  def dup
    duped_board = Board.new
    duped_board.grid = Array.new(8) {Array.new(8)}
    # 0.upto(7) do |row|
    #   @grid[row].each_index do |index|
    #     unless @grid[row][index].nil?
    #       duped_grid[row][index] = @grid[row][index].dup(duped_board)
    #     end
    #   end
    # end

    pieces.each do |piece|
      piece.dup(duped_board)
    end

    duped_board
  end

  def render
    print ("A".."H").to_a.join
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
