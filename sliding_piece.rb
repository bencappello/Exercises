require_relative 'piece'

class SlidingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  # def moves
  #   possible_move_coords = move_dirs.map do |(dx, dy)|  #coordinate
  #     [pos[0] + dx, pos[1] + dy]
  #   end.select do |row, col|
  #     [row, col].all? do |coord|
  #       coord.between?(0, 7)
  #     end
  #   end
  #   possible_move_coords.select do |pos|
  #     @board[pos].nil? || @board[pos].color == other_color(@color) #valid move spaces
  #   end
  # end


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
