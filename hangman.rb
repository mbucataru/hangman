words = File.readlines('words.txt').filter { |word| (5..12).include?(word.chomp.length) }
words = words.map(&:chomp)

p words.sample
