require_relative "sliding_piece"

class Rook < SlidingPiece
  DELTAS = [[0,1], [1,0], [0,-1], [-1, 0]]
  def move_dirs
    DELTAS
  end
end
