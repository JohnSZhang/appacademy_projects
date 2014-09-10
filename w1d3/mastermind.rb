class MasterMind
  attr_accessor :turns, :pegs

  def initialize(turns = 10)
    @turns = turns
    @pegs = Peg.new
  end

  def play
    i = 0

    while i < self.turns
      puts "correct #{self.pegs.hidden_pegs}"
      if player_turn
        puts "You Win!!"
        exit
      end
      i += 1
      puts "You are at turn #{i}, hurry up"
    end
    puts "You are not very good at this game :( "
  end

  def your_guess
    puts "\nTake a guess\n"
    puts "You can choose from #{self.pegs.PEGS}"
    gets.chomp
  end

  def player_turn
    player_guess = self.pegs.parse your_guess

    correct_match = self.pegs.exact_match(player_guess)
    near_match = self.pegs.near_match(player_guess)
    puts "There were #{correct_match} exact matches."
    puts "There were #{near_match} near matches."
    correct_match == 4 ? true : false
  end
end

class Peg

  PEGS = %w(R G B Y O P)
  attr_accessor :hidden_pegs
  attr_reader :PEGS

  def randomize
    PEGS.shuffle.first(4)
  end

  def initialize
    self.hidden_pegs = self.randomize
    @PEGS = PEGS
  end

  def parse(input)
    input.upcase.split('')
  end

  def exact_match(guess)
    correct = 0
    guess.each_with_index do |color, position|
      correct += 1 if self.hidden_pegs[position] == color
    end
    correct
  end

  def near_match(guess)
    correct = 0
    guess.each do |color|
      correct += 1 if self.hidden_pegs.include?(color)
    end
    correct - exact_match(guess)
  end

end





