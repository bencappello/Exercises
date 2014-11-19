require_relative "sliding_piece"


class Bishop < SlidingPiece

  attr_reader :render
  DELTAS = [1,-1].repeated_permutation(2).to_a
  ICONS =
  {
    w: "♗",
    b: "♝"
  }
  def initialize(color, pos, board)
    super(color, pos, board)
    @render = ICONS[color]
  end

  def move_dirs
    DELTAS
  end


end
