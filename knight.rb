require_relative "stepping_piece"
class Knight < SteppingPiece

  attr_reader :render

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

  ICONS =
  {
    w: "♘",
    b: "♞"
  }
  def initialize(color, pos, board)
    super(color, pos, board)
    @render = ICONS[color]
  end


  def move_dirs
    DELTAS
  end
end
