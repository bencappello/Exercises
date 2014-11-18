require_relative 'piece'

class SteppingPiece < Piece

  def initialize(color, pos)
    super(color, pos)
  end

  def moves
    move_dirs
  end

end
