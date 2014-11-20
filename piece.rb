require_relative 'require_files'

class Piece
  COLORS = [:white, :black]

  attr_reader :color, :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def render
    pieces = { black: "☻", white: "☺" }
    pieces[@color]
  end

  def move_diffs
    deltas = { black: [[1, -1], [1, 1]], white: [[-1, 1], [-1, -1]] }
    deltas[@color]
  end

  def slides
    slides = []
    move_diffs.each do |delta|
      new_pos = pos_plus_delta(@pos, delta)
      slides << new_pos if @board[new_pos].nil?
    end

    slides.select {|pos| (0..7).include?(pos.first) && (0..7).include?(pos.last)}
  end

  def pos_plus_delta(pos1, delta, multiplier = 1)
    final_pos = [(pos1[0] + delta[0]*multiplier), (pos1[1] + delta[1]*multiplier)]
  end

  def perform_moves(move_sequence)
    if move_sequence.length == 1
      move = move_sequence.first
      unless perform_slide(move) || perform_jump(move)
          raise InvalidMoveError.new "#{move} is not a valid move"
      end
    elsif valid_move_seq?(move_sequence)
        move_sequence.each { |move| perform_jump(move) }
    end
  end

  def valid_move_seq?(move_sequence)
    duped_piece = self.class.new(@color, @pos, @board.dup)

    #perform_jump also returns true/false depending on if it's a valid jump
    move_sequence.each do |move|
      unless duped_piece.perform_jump(move)
        raise InvalidMoveError.new "#{move} is not a valid move"
      end
    end

    true
  end

  def jumps
    jumps = []
    move_diffs.each do |delta|
      jumped_pos = pos_plus_delta(@pos, delta)
      new_pos = pos_plus_delta(@pos, delta, 2)
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
    maybe_promote
    true
    #returns true/false so it can also be used to test if the input position
    #is a valid slide position
  end

  def perform_jump(final)
    return false unless jumps.include?(final)

    jumped_row = @pos[0] + ((final[0] - @pos[0]) / 2)
    jumped_column = @pos[1] + ((final[1] - @pos[1]) / 2)
    jumped_piece_pos = [jumped_row, jumped_column]

    @board[jumped_piece_pos] = nil
    @board[@pos] = nil
    @board[final] = self
    @pos = final
    maybe_promote
    true
    #returns true/false so it can also be used to test if the input position
    #is a valid jump position
  end

  def maybe_promote
    return unless self.class == Piece
    if @color == :white
      promote if @pos.first == 0
    else #color == :black
      promote if @pos.first == 7
    end
  end

  def promote
    king = KingPiece.new(@color, @pos, @board)
    @board[@pos] = king
  end

end


class KingPiece < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def move_diffs
    [[1, -1], [1, 1], [-1, 1], [-1, -1]]
  end

  def render
    pieces = { black: "♛", white: "♕" }
    pieces[@color]
  end


end

#raise InvalidMoveError.new
