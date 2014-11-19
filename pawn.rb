require_relative "piece"
class Pawn < Piece

  attr_reader :render
  FIRST_FORWARD_DELTAS = {:w => [[-1, 0], [-2, 0]], :b => [[1, 0], [2, 0]] }
  FORWARD_DELTAS = {:w => [[-1, 0]], :b => [[1, 0]] }
  ATTACK_DELTAS = {:w => [[-1, 1], [-1, -1]], :b => [[1, 1], [1, -1]] }
  ICONS =
  {
    w: "♙",
    b: "♟"
  }


  def initialize(color, pos, board)
    super(color, pos, board)
    @render = ICONS[color]
  end

  def valid_forward_move?(position) #refactor to combine pos[0] and pos[1] into array and use any?
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

  def first_forward_moves
    FIRST_FORWARD_DELTAS[@color].map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end
  end

  def other_forward_moves
    FORWARD_DELTAS[@color].map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end
  end

  def attack_moves
    ATTACK_DELTAS[@color].map do |(dx, dy)|
      [@pos[0] + dx, @pos[1] + dy]
    end
  end

  def moves
    all_moves = []
    #first forward moves
    if (@color == :w && @pos[0] == 6) || (@color == :b && @pos[0] == 1)

      first_forward_moves.each do |position|
        all_moves << position if valid_forward_move?(position)
      end

    else # other forward moves
      other_forward_moves.each do |position|
        all_moves << position if valid_forward_move?(position)
      end

    end

    #attack moves
    attack_moves.each do |position|
      all_moves << position if valid_attack_move?(position)
    end

    all_moves
  end

end
