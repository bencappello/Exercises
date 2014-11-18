require_relative "piece"
class Pawn < Piece
  DELTAS = [0,1]


  def initialize(color, pos)
    super(color, pos)
  end


  def move_dirs
    DELTAS
  end
end
