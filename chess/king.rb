require_relative "stepping_piece"

class King < SteppingPiece

  attr_reader :render

  DELTAS = [1,-1,0].repeated_permutation(2).to_a
  DELTAS.delete([0,0])
  ICONS =
  {
    w: "♔",
    b: "♚"
  }

  def initialize(color, pos, board)
    super(color, pos, board)
    @render = ICONS[color]
  end

  def move_dirs
    DELTAS
  end
end
