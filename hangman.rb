#Computer, Human, Game classes

#

class Game

  def initialize(guesser, ref)
    @incorrect_guesses = 0
    @guesser = guesser
    @ref = ref
  end

  def assign_answer
    @answer = @ref.generate_answer
    @right_guesses = @answer.dup.gsub(/./, "_").chars
    @guesser.receive_secret_length(@answer.length)
  end

  def play
    assign_answer

    until win?
      if @incorrect_guesses > 9
        puts "You ran out of turns!"
        puts "The answer is #{@answer}"
        return
      end

      current_guess = @guesser.get_guess
      @guesser.guesses << current_guess

      if correct_guess?(current_guess)

        mod_right_guess(current_guess)

        indices = []
        @answer.dup.chars.each_index do |i|
          if @answer[i] == current_guess
            indices << i
          end
        end

        @guesser.mod_dictionary(true, indices)
        output
      else
        puts "You suck there is no #{current_guess}"
        @incorrect_guesses += 1
        @guesser.mod_dictionary(false)
        output
      end


    end

    puts "You win. Yayyy!"
    return nil
  end


  private


  def output
    puts "Secret word: #{@right_guesses.join}"
    puts "Guesses: #{@guesser.guesses}"
    puts "#{@incorrect_guesses} incorrect guesses"
    puts "#{@answer}" if @guesser.is_a?(ComputerPlayer)
  end

  def win?
    @answer == @right_guesses.join
  end

  def correct_guess?(current_guess)
    @answer.dup.chars.include?(current_guess)
  end

  def mod_right_guess(guessed_letter)
      @right_guesses = @ref.mod_scenario(@right_guesses, @answer, guessed_letter)[0]

  end

end


class ComputerPlayer

  attr_reader :guess, :guesses

  def initialize
    @guess = guess
    @guesses = []
  end

  def receive_secret_length(answer_length)
    @answer_length = answer_length
    words = File.readlines("dictionary.txt")
    words = words.map { |el| el.chomp }
    @dictionary = words.select { |word| word.length == answer_length }
  end

  def mod_dictionary(response, indices = [])
    if response
      @dictionary.select! do |word|
        indices.all? do |i|
          word[i] == @guess
        end
      end
      puts "dictionary length: #{@dictionary.length}"
    else
      @dictionary.reject! { |word| word.include?(@guess) }
      puts "dictionary length: #{@dictionary.length}"
    end
  end

  def get_guess
    common_letters = Hash.new { |hash, key| hash[key] = 0 }
    letter_bank = @dictionary.inject(:+).chars
    letter_bank.reject! do |el|
      @guesses.include?(el)
    end
    letter_bank.each do |letter|
      common_letters[letter] += 1
    end
    common_letter = common_letters.max_by do |key, value|
      value
    end
    yes = true
    while yes == true
      letter = common_letter[0]
      if @guesses.none? { |l| l == letter }
        @guess = letter
        yes = false
      end
    end

    @guess
  end

  def

  def generate_answer
    words = File.readlines("dictionary.txt")
    words = words.map { |el| el.chomp }
    words.sample
  end

  def mod_scenario(scenario, answer, guessed_letter)
      answer.dup.chars.each_index do |i|
        if answer[i] == guessed_letter
          scenario[i] = guessed_letter
        end
      end
      scenario
  end

end

class HumanPlayer

  attr_accessor :guess, :guesses

  def initialize
    @guess = guess
    @guesses = []
  end

  def receive_secret_length(answer_length)
    @answer_length = answer_length
  end

  def get_guess
    puts "Take a guess you idiot:"
    print ">"
     gets.chomp
  end



  def generate_answer
    puts "Choose a word length"
    desired_length = gets.chomp.to_i
    words = File.readlines("dictionary.txt")
    words = words.map { |el| el.chomp }
    words_of_right_length = words.select { |word| word.length == desired_length }
    words_of_right_length.sample
  end



  def mod_scenario(scenario, answer, guessed_letter)
    puts "Computer Guess is #{guessed_letter}"
    puts "Answer is #{answer}"
    puts "Tell computer the index(s) where the guessed letter appears"
    indices = gets.chomp.split.map! { |n| n.to_i }
    scenario.each_index do |i|
      scenario[i] = guessed_letter if indices.include?(i)
    end

    [scenario, indices]
  end

  def mod_dictionary
  end
end

n = Game.new(ComputerPlayer.new, HumanPlayer.new)
n.play
