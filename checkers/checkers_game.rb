require_relative 'require_files'
require 'yaml'

class Game

COLORS = { white: "White", black: "Black" }

attr_reader :board

  def initialize
    @board = Board.new
    @board.starting_positions
    @white_player = HumanPlayer.new(:white)
    @black_player = HumanPlayer.new(:black)
  end

  def play
    next_player = @white_player
    other_player = @black_player
    @board.render
    until @board.black_pieces.empty? || @board.white_pieces.empty?
      begin
        input = next_player.get_input
        play_turn(input, next_player.color)
      rescue MoveError => e
        puts "#{e.message}"
        puts ""
        retry
      end
      next_player, other_player = other_player, next_player
      @board.render
    end

    win(other_player.color)
  end

  def play_turn(input, player_color)
    piece, moves = input

    if @board[piece].nil?
      raise MoveError.new "There is no piece at that start position"
    elsif
      @board[piece].color != player_color
      raise MoveError.new "You can't move the other player's pieces. That would be cheating."
    end
    @board[piece].perform_moves(moves)
  end

  def win(color)
    puts "Yay #{COLORS[color]} player, you are the best checkers player in the world!"
  end

end


class HumanPlayer

  COLORS = { white: "White", black: "Black" }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input
    begin
      puts "#{COLORS[@color]} player's turn"
      puts "What piece do you want to move?"
      print ">"
      piece = parse_moves.first
    rescue InputError => e
      puts "#{e.message}"
      puts ""
      puts ""
      retry
    end

    begin
      puts "What move(s) do you want to make? If you want to make multiple jumps, put in all the jump locations separated by commas."
      print ">"
      moves = parse_moves
    rescue InputError => e
      puts "#{e.message}"
      puts ""
      retry
    end

    [piece, moves]
  end

  def parse_moves
    moves = gets.chomp.upcase.split(",").map(&:strip)
    parsed_moves = []
    moves.each do |move|
      parsed_moves << parse_position(move)
    end
    raise InputError.new "Please input a valid space in the form 'A1'" if parsed_moves.empty?

    parsed_moves
  end

  def parse_position(pos)
    columns = %w(A B C D E F G H)
    unless pos.length == 2 && columns.include?(pos[0])  && ("1".."8").include?(pos[1])
      raise InputError.new "Please input a valid space in the form 'A1'"
    end

    location = []
    pos.each_char do |char|
      if ("A".."H").include?(char)
        location << columns.index(char).to_s
      else
        location << (char.to_i - 1).to_s
      end
    end

    location = location.map{|num| num.to_i}.reverse
  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end
end



if $PROGRAM_NAME == __FILE__
  case ARGV.count
  when 0
    Game.new.play
  when 1
    # resume game, using first argument
    YAML.load_file(ARGV.shift).play
  end
  Game.new.play
end
