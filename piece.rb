class Piece

  attr_accessor :color, :pos, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end


  # update_board method which will deep_dup the current board before checking for moves, etc.



  def other_color(color)
    color == :w ? :b : :w
  end

  # def moves
  #   possible_move_tiles
  # end

end
