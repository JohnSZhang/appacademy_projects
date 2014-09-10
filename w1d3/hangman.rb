class Dictionary

  attr_accessor :word_bank

  def self.load
    File.readlines('dictionary.txt').map(&:chomp)
  end

  def initialize
    self.word_bank = self.class.load
  end

  def random_words_of_length(length = 20)
   self.word_bank.select{|word| word.length == length}
  end

  def random_word(length = nil)
    return self.word_bank.sample if length == nil

    self.random_words_of_length(length).sample
  end

end

class Game

  attr_reader :checking_player, :guessing_player

  def initialize(option = {})

    default_options = {checking: "C", guessing: "H"}
    option = default_options.merge(option)
    @checking_player = (option[:checking] == "C" ? ComputerPlayer.new : HumanPlayer.new)
    @guessing_player = (option[:guessing] == "C" ? ComputerPlayer.new : HumanPlayer.new)
  end

  def setup_game
    self.checking_player.new_secret_word
    self.guessing_player.start_new_word(self.checking_player.secret_length)
  end

  def play
    setup_game
    until self.guessing_player.won?
      guess = self.guessing_player.guess
      response = self.checking_player.check_guess(guess)
      self.guessing_player.handle_guess_response(response)
    end
  end
end


class Player

  attr_accessor :secret_word, :guessed_position, :letters_guessed, :current_guess

  def initialize
    self.letters_guessed = []
    self.current_guess = ''

  end

  def start_new_word(length = 0)

    self.guessed_position = Array.new(length, '')

  end

  def won?
    guessed_position.all?{|position| position != ""}
  end

  def secret_length
    self.secret_word.length
  end

end

class HumanPlayer < Player

  def guess
    puts "Letters used: #{self.letters_guessed}"
    puts "Guess a letter\n"
    letter = gets.chomp
    self.letters_guessed << letter
    self.current_guess = letter
    letter
  end

  def new_secret_word
    puts "Pick a secret word"
    self.secret_word = gets.chomp
  end

  def check_guess(letter)
    puts "Is the letter in the word?"
    gets.chomp
  end

  def handle_guess_response(position)
    return nil if positions == ''
    positions.split('').map(&:to_i).each do |pos|
      self.guessed_position[pos] = self.current_guess
    end
  end
end

class ComputerPlayer < Player

   attr_accessor    :possible_words
   attr_reader      :dictionary

   def initialize
     @dictionary = Dictionary.new
     self.possible_words = []
     super
   end

  def handle_guess_response(positions)
    return nil if positions == ''

    positions.split('').each do |pos|
      next if pos == ' '
      self.guessed_position[pos.to_i] = self.current_guess
    end

    self.possible_words = self.filter_words

  end

  def start_new_word(length = 0)
    self.possible_words = self.dictionary.random_words_of_length(length)
    super
  end

  def most_frequent_letter
    frequency = Hash.new {|h,k| h[k] = 0}

    self.possible_words.each do |word|
      word.each_char do |letter|
        frequency[letter] += 1
      end
    end

    freq_letter = frequency.sort_by{ |key, value| value }.last.first

    while self.letters_guessed.include?(freq_letter)
      frequency[freq_letter] = -1
      freq_letter = frequency.sort_by{ |key, value| value }.last.first
    end

    freq_letter
  end

  def filter_words
    self.possible_words.select { |word|
      word.split("").each_with_index.all? do |letter, index|
        (self.guessed_position[index] == letter) || (self.guessed_position[index] == '')
      end
    }
  end

  def guess
    self.current_guess = self.most_frequent_letter
    self.letters_guessed << self.current_guess
    puts "Computer Guesses #{self.current_guess}"
    self.current_guess
  end

  def new_secret_word
    self.secret_word = self.dictionary.random_word
  end

  def check_guess(letter)
    display = ""
    self.letters_guessed << letter

    self.secret_word.each_char do |letter|
      display << (self.letters_guessed.include?(letter) ? letter : "_")
    end

    puts "Secret Word : #{display}"

    position = []
    self.secret_word.each_char.with_index do |char, index|
      position << index if ( char == letter )
    end
    position.join(' ')
  end

end



if __FILE__ == $PROGRAM_NAME

  possible_words = ["cat", "hat", "fit"]
  guessed_position = ['','a','']

  possible_words.each do |word|
  if (word.split('').each_with_index.all? do |letter, index|
      guessed_position[index] == letter || guessed_position[index] == ''
      end)
      p word
    end
  end

  p possible_words.select { |word|
    word.split("").each_with_index.all? do |letter, index|
      guessed_position[index] == letter || guessed_position[index] == ''
    end
  }
end
