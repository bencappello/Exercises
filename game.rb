require_relative "pieces_require"
require_relative "board"


class Game

  COLORS = { w: "White", b: "Black" }

  def initialize
    @board = Board.new
    @white_player = HumanPlayer.new(:w)
    @black_player = HumanPlayer.new(:b)
  end

  def inspect
  end

  def play

    next_player = @white_player
    other_player = @black_player

    until @board.check_mate?(:b) || @board.check_mate?(:w)
      @board.render
      next_player.play_turn(next_player.color)

      next_player, other_player = other_player, next_player
    end

    win(other_player.color)

  end

  def win(color)
    Puts "Congratulations #{COLORS[color]} player! Check mate."
  end
end


class HumanPlayer

  COLORS = { w: "white", b: "black" }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(color)
    puts "What piece do you want to move #{COLORS[color]}?"
    move = gets.chomp.upcase
    start = []
    columns = %w(A B C D E F G H)

    move.each_char do |char|
      if ("A".."H").include?(char)
        start << columns.index("F")
      else
        start << (char.to_i - 1).to_s
      end
    end
    start = start.split("").map{|num| num.to_i}

    puts "Where do you want to move it?"
    move = gets.chomp.upcase
    final = []
    columns = %w(A B C D E F G H)

    move.each_char do |char|
      if ("A".."H").include?(char)
        final << columns.index("F")
      else
        final << (char.to_i - 1).to_s
      end
    end
    final = final.split("").map{|num| num.to_i}
    [start,final]
  end

end
