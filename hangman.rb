# Contains the logic for Hangman
class Hangman
  attr_accessor :word, :display_word, :guess_count, :previous_guesses

  def initialize(input)
    initialize_with_string(input) if input.is_a?(String)
    initialize_with_hash(input) if input.is_a?(Hash)
  end

  def initialize_with_string(word)
    @word = word
    @display_word = '_' * word.length
    @previous_guesses = []
    @guess = ''
    @guess_count = 6
    @save_status = false
  end

  def initialize_with_hash(hash)
    @word = hash['word']
    @display_word = hash['display_word']
    @previous_guesses = hash['previous_guesses']
    @guess_count = hash['guess_count']
    @guess = ''
    @save_status = false
  end

  def to_hash
    {
      word: @word,
      display_word: @display_word,
      previous_guesses: @previous_guesses,
      guess_count: @guess_count
    }
  end

  def find_indexes(word, guess)
    indexes = []
    word.each_char.with_index do |char, index|
      indexes.push(index) if char == guess
    end
    indexes
  end

  def user_guess
    puts "You have #{guess_count} guesses left"
    puts display_word
    puts 'Enter your guess'
    puts 'If you would like to quit and save, enter QS'
    gets.chomp.downcase
  end

  def check_guess(guess)
    if word.include?(guess)
      indexes = find_indexes(word, guess)
      indexes.each { |index| display_word[index] = guess }
    elsif previous_guesses.include?(guess)
      puts 'You already guessed that word!'
    else
      @guess_count -= 1
      previous_guesses.push(guess)
    end
  end

  def play_round
    return false if guess_count.zero? || previous_guesses.length == 6 || !display_word.include?('_')

    guess = user_guess
    if guess == 'qs'
      File.write('save.json', JSON.dump(to_hash))
      @save_status = true
      return false
    else
      check_guess(guess)
    end
    true
  end

  def play
    while play_round

    end
    if @save_status
      puts 'Game has been saved'
    elsif display_word.include?('_')
      puts "You ran out of guesses :( The word was #{word}"
    else
      puts 'Congratulations! You won the game!'
    end
  end
end
