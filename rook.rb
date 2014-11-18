require_relative "sliding_piece"

class Rook < SlidingPiece
  DELTAS = [[0,1], [1,0], [0,-1], [-1, 0]]

  def initialize(color, pos)
    super(color, pos)
  end




  def move_dirs
    DELTAS
  end
end
