words = File.readlines('words.txt').filter { |word| (5..12).include?(word.chomp.length) }

puts words.sample
