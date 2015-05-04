require_relative "sliding_piece"

class Rook < SlidingPiece
  attr_reader :render

  DELTAS = [[0,1], [1,0], [0,-1], [-1, 0]]
  ICONS =
  {
    w: "♖",
    b: "♜"
  }
  def initialize(color, pos, board)
    super(color, pos, board)
    @render = ICONS[color]
  end




  def move_dirs
    DELTAS
  end
end
