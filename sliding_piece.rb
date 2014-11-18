require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    move_dirs
  end

  def neighbors
    possible_move_coords = move_dirs.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |row, col|
      [row, col].all? do |coord|
        coord.between?(0, 7)
      end
    end

    possible_move_coords.select { |pos| @board[pos] }
      neighbor_tiles.select { |tile| tile.nil? }
  end





end
