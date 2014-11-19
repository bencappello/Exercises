class Piece

  attr_accessor :color, :pos, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @board[pos] = self
  end
  def other_piece(position)
    !@board[position].nil? && @board[position].color == other_color(@color)
  end

  def dup(board = nil)
    new_piece = self.class.new(self.color, self.pos.dup, board)

  end

  def inspect
    {
      color: color,
      pos: pos,
      class: self.class.to_s
    }.inspect
  end


  def valid_move?(position) #refactor to combine pos[0] and pos[1] into array and use any?
    return false unless position[0].between?(0, 7)
    return false unless position[1].between?(0, 7)
    return false unless (@board[position].nil? || @board[position].color == other_color(@color))
    return true
  end

  # update_board method which will deep_dup the current board before checking for moves, etc.

  def move_into_check?(final_pos)#i.e.final
    duped_board = @board.dup
    duped_board.make_move(@pos, final_pos)

    return true if duped_board.in_check?(@color)
    self.inspect
    false
  end


  def other_color(color)
    color == :w ? :b : :w
  end


end
