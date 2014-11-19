require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    extended_moves = []
    move_dirs.each do |(dx, dy)|
      position =  [@pos[0] + dx, @pos[1] + dy]
      until !valid_move?(position)
        extended_moves << position
        break if other_piece(position)
        position =  [position[0] + dx, position[1] + dy]
      end
    end
    extended_moves
  end

end
