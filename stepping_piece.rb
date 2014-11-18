require_relative 'piece'

class SteppingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    move_dirs
  end

end
