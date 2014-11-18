class Piece

  attr_accessor :color, :pos, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def other_piece(position)
    !@board[position].nil? && @board[position].color == other_color(@color)
  end


  def valid_move?(position)
    return false unless position[0].between?(0, 7)
    return false unless position[1].between?(0, 7)
    return false unless (@board[position].nil? || @board[position].color == other_color(@color))
    return true
  end

  # update_board method which will deep_dup the current board before checking for moves, etc.



  def other_color(color)
    color == :w ? :b : :w
  end

  # def moves
  #   possible_move_tiles
  # end

end
