# Contains the logic for Hangman
class Hangman
  def initialize(word)
    @word = word
  end
end

# Contains the logic for prompting the user to start the game
class Game
  @words = File.readlines('words.txt').filter { |word| (5..12).include?(word.chomp.length) }.map(&:chomp)

  def self.play
    input = ''
    puts 'Welcome to Hangman!'
    sleep(5)
    while input != 'Q'
      play_round
      sleep(8)
      puts 'If you would like to play again, press enter'
      puts 'To quit, press Q and enter'
      input = gets.chomp
    end
  end

  def self.play_round
    game = Hangman.new(@words.sample)
  end
end

Game.play
