class Code
  PEGS = [:R, :G, :B, :Y, :O, :P]

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def self.parse(input)
      input = input.upcase
      unless input.split("").all? { |l| PEGS.include?(l.to_sym) }  && input.length == 4
        raise ArgumentError.new "Invalid input"
      end
      pegs = []
      input.split("").each { |el| pegs << el.to_sym}
      self.new(pegs)
  end

  def self.random
    rando = []
    4.times do
      rando << PEGS.sample #return random 4 letters
    end
    self.new(rando)
  end

  def compare(guess)
    #check if win
    perfect_guesses = exact_match(guess.pegs)
    close_guesses = near_match(guess.pegs, perfect_guesses)

    hints(perfect_guesses, close_guesses)
  end


  private

  def exact_match(guess_pegs)
    exact_matches = []

    guess_pegs.each_with_index do |el, i|
      exact_matches << el if el == @pegs[i]
    end
    exact_matches.count
  end

  def near_match(guess_pegs, perfect_guesses)
    guess_matches = []
    answer_matches = []

    guess_pegs.each_with_index do |el, i|
      guess_matches << el if @pegs.include?(el)
    end

    @pegs.each do |el|
      answer_matches << el if guess_pegs.include?(el)
    end

    # near_matches = []
    # answer = @pegs.dup
    #
    # guess_pegs.each_with_index do |el, i|
    #   if pegs.include?(el) && el != answer[i]
    #     near_matches << el
    #     answer[i] = nil
    #   else
    #     next
    #   end
    # end

    shared = [guess_matches.count, answer_matches.count].min
    near_matches = shared - perfect_guesses

    # puts near_matches
    near_matches
  end

  def hints(perfect_guesses, close_guesses)
    [perfect_guesses, close_guesses]
  end
end

class Game

  attr_reader :turn

  def initialize
    @turn = 1
    @answer = Code.random
  end

  def play
    while true
      if @turn > 10
        puts "You ran out of turns!"
        puts "The answer is #{@answer.pegs}"
        return
      end

      puts "Input your guess (RGBYOP): "

      begin
        guess = Code.parse(gets.chomp)
      rescue ArgumentError => e
        puts "Please enter in a string of four letters"
        puts e.message
        retry
      end

      if win?(guess)
        puts "You win!"
        return
      end
      output(guess)

      @turn += 1
    end
  end

  def output(guess)
    puts "Your guess is #{guess.pegs}"
    puts "You had #{@answer.compare(guess)[0]} exact matches and #{@answer.compare(guess)[1]} near matches"
    puts "You have #{ (10 - @turn) } more guesses"
  end


  private

  def win?(guess)
    @answer.pegs == guess.pegs
  end

end
