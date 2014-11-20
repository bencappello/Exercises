require_relative 'require_files'

class Piece
  COLORS = [:white, :black]

  attr_reader :color

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def render
    pieces = { black: "★", white: "☆" }
    pieces[@color]
  end

  def move_diffs
    deltas = { black: [[1, -1], [1, 1]], white: [[-1, 1], [-1, -1]] }
    deltas[@color]
  end

  def slides
    slides = []
    move_diffs.each do |delta|
      new_pos = [(@pos[0] + delta[0]), (@pos[1] + delta[1])]
      slides << new_pos if @board[new_pos].nil?
    end

    slides.select {|pos| (0..7).include?(pos.first) && (0..7).include?(pos.last)}
  end

  def jumps
    jumps = []
    move_diffs.each do |delta|
      jumped_pos = [(@pos[0] + delta[0]), (@pos[1] + delta[1])]
      new_pos = [(@pos[0] + delta[0]*2), (@pos[1] + delta[1]*2)]
      unless @board[jumped_pos].nil? || @board[jumped_pos].color == @color
        jumps << new_pos if @board[new_pos].nil?
      end
    end

    jumps.select {|pos| (0..7).include?(pos.first) && (0..7).include?(pos.last)}
  end

  def perform_slide(final)
    return false unless slides.include?(final)
    # raise InvalidMoveError.new "some shit" unless @board[final].nil?
    @board[@pos] = nil
    @board[final] = self
    @pos = final
    true
  end

  def perform_jump
    return false unless jumps.include?(final)

    @board[@pos] = nil
    @board[final] = self
    @pos = final
    true
  end

  def maybe_promote
  end

end


class KingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def move_diffs
    [[1, -1], [1, 1], [-1, 1], [-1, -1]]
  end


end
