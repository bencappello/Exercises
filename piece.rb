class Piece

  def initalize(color, pos)
    @color = color
    @pos = pos
    @board = board.dup
  end


  # update_board method which will deep_dup the current board before checking for moves, etc.



  # def moves
  #   possible_move_tiles
  # end

end
