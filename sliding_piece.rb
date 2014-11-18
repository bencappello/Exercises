require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, pos)
    super(color, pos)
  end

  def moves
    move_dirs
  end


end
