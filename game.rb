require_relative 'require_files'

class Game

COLORS = { white: "White", black: "Black" }

  def initialize
    @board = Board.new
    @white_player = HumanPlayer.new(:w)
    @black_player = HumanPlayer.new(:b)
  end




end




if $PROGRAM_NAME == __FILE__
  # running as script
  Game.new.play
end
