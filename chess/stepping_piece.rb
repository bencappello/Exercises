require_relative 'piece'

class SteppingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves

    move_dirs.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select {|position| valid_move?(position)}
  end

end
