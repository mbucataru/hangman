# Contains the logic for Hangman
class Hangman
  def initialize(word)
    @word = word
    @display_word = '_' * word.length
    @previous_guesses = []
    @guess = ''
    @guess_count = 6
  end

  attr_accessor :word, :display_word, :guess_count, :unguessed_count, :previous_guesses, :guess

  def find_indexes(word, guess)
    indexes = []
    word.each_char.with_index do |char, index|
      indexes.push(index) if char == guess
    end
    indexes
  end

  def play_round
    return false if guess_count.zero? || previous_guesses.length == 6 || !display_word.include?('_')

    puts "You have #{guess_count} guesses left"
    puts display_word
    puts 'Enter your guess'
    guess = gets.chomp.downcase
    if word.include?(guess)
      indexes = find_indexes(word, guess)
      indexes.each { |index| display_word[index] = guess }
    else
      @guess_count -= 1
      previous_guesses.push(guess)
    end
    true
  end

  def play
    while play_round

    end
    if display_word.include?('_')
      puts 'You ran out of guesses :('
    else
      puts 'Congratulations! You won the game!'
    end
  end
end

# Contains the logic for prompting the user to start the game
class Game
  @words = File.readlines('words.txt').filter { |word| (5..12).include?(word.chomp.length) }.map(&:chomp)

  def self.play
    input = ''
    puts 'Welcome to Hangman!'
    sleep(0)
    while input != 'Q'
      Hangman.new(@words.sample).play
      sleep(8)
      puts 'If you would like to play again, press enter'
      puts 'To quit, press Q and enter'
      input = gets.chomp
    end
  end
end

Game.play
