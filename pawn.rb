require_relative "piece"
class Pawn < Piece
  DELTAS = [0,1]


  def initialize(color, pos, board)
    super(color, pos, board)
  end


  def move_dirs
    DELTAS
  end
end
