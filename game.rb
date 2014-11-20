require_relative "pieces_require"
require_relative "board"
require_relative "errors"


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
    @board.render
    until @board.check_mate?(:b) || @board.check_mate?(:w)
      begin
        input = next_player.get_input(next_player.color)
        play_turn(input, next_player.color)
      rescue MoveError => e
        puts "#{e.message}"
        retry
      end
      next_player, other_player = other_player, next_player
      @board.render
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
    puts "Congratulations #{COLORS[color]} player! Check mate."
  end
end


class HumanPlayer

  COLORS = { w: "White", b: "Black" }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input(color)
    begin
      puts "#{COLORS[color]} player's turn"
      puts "What piece do you want to move?"
      start = get_move
    rescue InputError => e
      puts "#{e.message}"
      retry
    end

    begin
      puts "Where do you want to move it?"
      final = get_move
    rescue InputError => e
      puts "#{e.message}"
      retry
    end

    [start, final]
  end

  def get_move
    move = gets.chomp.upcase
    columns = %w(A B C D E F G H)
    unless columns.include?(move[0])  && ("1".."8").include?(move[1])
      raise InputError.new "Please input a valid space in the form 'A1'"
    end

    location = []
    move.each_char do |char|
      if ("A".."H").include?(char)
        location << columns.index(char).to_s
      else
        location << (char.to_i - 1).to_s
      end
    end
    location = location.map{|num| num.to_i}.reverse
  end

end

if $PROGRAM_NAME == __FILE__
  # running as script
  Game.new.play
end
