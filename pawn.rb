require_relative "piece"
class Pawn < Piece
  FIRST_DELTAS = {:w => [[-1, 0], [-2, 0]], :b => [[1, 0], [2, 0]] }
  FORWARD_DELTAS = {:w => [[-1, 0]], :b => [[1, 0]] }
  ATTACK_DELTAS = {:w => [[-1, 1], [-1, -1]], :b => [[1, 1], [1, -1]] }


  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def valid_forward_move?(position)
    return false unless position[0].between?(0, 7)
    return false unless position[1].between?(0, 7)
    return false unless @board[position].nil?
    return true
  end

  def valid_attack_move?(position)
    return false unless position[0].between?(0, 7)
    return false unless position[1].between?(0, 7)
    return false if @board[position].nil? || @board[position].color == color
    return true
  end

  def moves
    all_moves = []
    #first forward moves
    if (@color == :w && @pos[0] == 6) || (@color == :b && @pos[0] == 1)
      first_moves = FIRST_DELTAS[@color].map do |(dx, dy)|
        [@pos[0] + dx, @pos[1] + dy]
      end
      first_moves.each do |position|
        all_moves << position if valid_forward_move?(position)
      end
    else # other forward moves
      moves = FORWARD_DELTAS[@color].map do |(dx, dy)|
        [@pos[0] + dx, @pos[1] + dy]
      end
      moves.each do |position|
        all_moves << position if valid_forward_move?(position)
      end
    end

    #attack moves
    attack_moves = ATTACK_DELTAS[@color].map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end
    attack_moves.each do |position|
      all_moves << position if valid_attack_move?(position)
    end
    all_moves
  end

end
