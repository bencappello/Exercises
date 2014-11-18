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

  def initialize(color, pos, board)
    super(color, pos, board)
  end


  def move_dirs
    DELTAS
  end
end
