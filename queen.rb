require_relative "sliding_piece"

class Queen < SlidingPiece
  DELTAS = [1,-1,0].repeated_permutation(2).to_a
  DELTAS.delete([0,0])

  def initialize(color, pos, board)
    super(color, pos, board)
  end


  def move_dirs
    DELTAS
  end
end
