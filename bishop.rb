require_relative "sliding_piece"

class Bishop < SlidingPiece
  DELTAS = [1,-1].repeated_permutation(2).to_a

  def initialize(color, pos)
    super(color, pos)
  end



  def move_dirs
    DELTAS
  end
end
