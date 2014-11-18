require_relative "stepping_piece"

class King < SteppingPiece

  DELTAS = [1,-1,0].repeated_permutation(2).to_a
  DELTAS.delete([0,0])

  def initialize(color, pos)
    super(color, pos)
  end

  def move_dirs
    DELTAS
  end
end
