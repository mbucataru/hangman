require 'json'
require_relative 'hangman'

# Contains the logic for prompting the user to start the game
class Game
  @words = File.readlines('words.txt').filter { |word| (5..12).include?(word.chomp.length) }.map(&:chomp)

  def self.play
    puts 'Welcome to Hangman!'
    puts 'If you would like to start from scratch, press S'
    puts 'If you would like to load your most recent save, press L'
    sleep(4)
    input = ''

    while input != 'S' && input != 'L'
      input = gets.chomp.upcase
      if input == 'S'
        Hangman.new(@words.sample).play
      elsif input == 'L'
        if File.exist?('save.json')
          file = File.read('save.json')
          hangman_hash = JSON.parse(file)
          Hangman.new(hangman_hash).play
        else
          puts 'You have no save file'
        end
      else
        puts 'Please type S or L'
      end
    end
  end
end
