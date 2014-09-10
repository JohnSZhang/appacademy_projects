#Q1 Write a number guessing game. The computer should choose a number between 1 and 100. It should prompt the user for guesses. Each time, it will prompt the user for a guess; it will return too high or too low. It should track the number of guesses the player took.
require 'debugger'
def number_game
  player_guess = 0
  answer = (1..100).to_a.sample
  p answer
  trail_number = 0
  while player_guess != answer
    player_guess = get_guess
    trail_number += 1
    case
    when player_guess > answer
      puts "too high"
    when player_guess < answer
      puts "too low"
    when player_guess == answer
      puts "you win! it took #{trail_number} tries!"
    end
  end
end

def get_guess
  guess = ''
  puts "guess a number between 1 and 100"
  guess = gets.strip.to_i
  while !((1..100).include? guess)
    puts "Not a valid input, please guess a number between 1 and 100"
    guess = gets
  end
  guess
end

#Q2 You've written an RPN calculator. Practice by rewriting your version better than you had before. It should have a user interface which reads from standard input one operand or operator at a time. You should be able to invoke it as a script from the command line. You should be able to, optionally, give it a filename on the command line, in which case it opens and reads that file instead of reading user input.
class RPNCalculator
  def initialize(options = {:string => nil, :filename => nil})
    @rpn_stack = []
    @rpn_stack = self.class.tokenize(string) if options[:string]
    @rpn_stack = self.class.tokenize(
        self.class.get_file options[:filename]) if options[:filename]
    @rpn_operands = [:+, :-, :*, :/]
    prompt_values if @rpn_stack == []
  end

  def self.get_file(string)
    File.read(string)
  end

  def prompt_values
    element = ''

    while element != "end"
      puts "Please enter the next element or end to finish input"
      element = gets.chomp
      @rpn_stack << self.class.tokenize(element)[0] if element != "end"
    end

  end

  def self.tokenize(string)
    operands = {"+" => :+, "-" => :-, "*" => :*, "/" => :/ }
    stack = []
    string = string.split(' ').each do |ele|
      if operands.has_key? ele
        stack << operands[ele]
      else
        stack << ele
      end
    end
    stack
  end

  def value_stack(stack)
    while stack.length != 1
      (stack.length-2).times do |start|
        a = stack[start]
        b = stack[start+1]
        c = stack[start+2]
        if !operand?(a) && !operand?(b) && operand?(c)
          value = operate(c, a, b)
          stack.delete_at start+2
          stack.delete_at start+1
          stack[start] = value
          break
        end
      end
    end
    stack[0]
  end

  def operate(operator, operand1, operand2)
    oper1 = operand1.to_i
    oper2 = operand2.to_i
    case
    when operator == :+
      return oper1 + oper2
    when operator == :-
      return oper1 - oper2
    when operator == :*
      return oper1 * oper2
    when operator == :/
      return oper1 / oper2
    end
  end

  def operand?(string)
    return @rpn_operands.include?(string)
  end

  def value
    return value_stack(@rpn_stack)
  end

end

#Q3 Write a program that prompts the user for a file name, reads that file, shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You could create a random number using the Random class, or you could use the shuffle method in array

def shuffle_file
  file_name = get_valid_file_name
  shuffled_name = "#{file_name.gsub(".txt",'')}-shuffled.txt"
  org_file_content = File.open(file_name).readlines
  shuffled_file = File.open(shuffled_name, "w")
  shuffled_file_content = org_file_content.shuffle
  shuffled_file.puts(shuffled_file_content)
  shuffled_file.close
end

def get_valid_file_name
  puts "Please Enter The Name Of File You Like To Shuffle Up"
  file_name = gets.strip
  valid_name = false
  while valid_name == false
    if File.exist?(file_name)
      valid_name = true
    else
      puts "That is not a valid name, please try again!"
      file_name = gets.strip
    end
  end
  return file_name
end

