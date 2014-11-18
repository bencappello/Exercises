require_relative "stepping_piece"
class Knight < SteppingPiece
    DELTAS = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def initialize(color, pos)
    super(color, pos)
  end


  def move_dirs
    DELTAS
  end
end
