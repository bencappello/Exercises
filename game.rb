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
      begin
        input = next_player.get_input(next_player.color)
        play_turn(input, next_player.color)
      rescue MoveError => e
        puts "#{e.message}"
        retry
      end

      next_player, other_player = other_player, next_player
    end
    win(other_player.color)
  end

  def play_turn(input, color)
    start, final = input
    unless  @board[start].nil? || @board[start].color == color
      raise MoveError.new "You can't move the other player's pieces. That would be cheating."
    end
    @board.move(start, final)
  end

  def win(color)
    Puts "Congratulations #{COLORS[color]} player! Check mate."
  end
end


class HumanPlayer

  COLORS = { w: "White", b: "Black" }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input(color)
    puts "#{COLORS[color]} player's turn"
    puts "What piece do you want to move?"
    move = gets.chomp.upcase
    start = []
    columns = %w(A B C D E F G H)

    move.each_char do |char|
      if ("A".."H").include?(char)
        start << columns.index(char).to_s
      else
        start << (char.to_i - 1).to_s
      end
    end
    start = start.map{|num| num.to_i}.reverse

    puts "Where do you want to move it?"
    move = gets.chomp.upcase
    final = []
    columns = %w(A B C D E F G H)

    move.each_char do |char|
      if ("A".."H").include?(char)
        final << columns.index(char).to_s
      else
        final << (char.to_i - 1).to_s
      end
    end
    final = final.map{|num| num.to_i}.reverse
    [start,final]
  end

end
