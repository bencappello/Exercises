require_relative "sliding_piece"

class Bishop < SlidingPiece
  DELTAS = [1,-1].repeated_permutation(2).to_a

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def move_dirs
    DELTAS
  end
  

end
