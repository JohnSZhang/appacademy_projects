#Q1
=begin
Write a set of classes to model Students and Courses.

Student#initialize should take a first and last name.
Student#name should return the concatenation of the student's first and last name.
Student#courses should return a list of the Courses in which the student is enrolled.
Student#enroll should take a Course object, add it to the student's list of courses, and update the Course's list of enrolled students.
enroll should ignore attempts to re-enroll a student.
Student#course_load should return a hash of departments to # of credits the student is taking in that department.
Course#initialize should take the course name, department, and number of credits.
Course#students should return a list of the enrolled students.
Course#add_student should add a student to the class.
Probably can rely upon Student#enroll.
=end
class Student

  attr_accessor :firstname, :lastname

  def initialize(fisrtname, lastname)
    @firstname = firstname
    @lastname = lastname
    @courses = []
  end

  def name
    "#{firstname} #{lastname}"
  end

  def courses
    @courses
  end

  def enroll(course)
    if has_conflict? course and not @courses.include?(course)
      puts "The Course You Are Trying To Enroll Conflicts With Schedule"

      return
    end
    if not @courses.include?(course)
      @courses << course
      course.add_student(self)
    end
  end

  def course_load
    current_load = {}
    @courses.each do |course|
      if current_load.has_key? course.department
        current_load[course.department] =
          current_load[course.department] + course.credits
      else
        current_load[course.department] = course.credits
      end
    end

    current_load
  end

  def has_conflict?(course)
    conflict = false
    @courses.each do |enrolled|
      conflict = true if enrolled.conflicts_with? course
    end

    conflict
  end

end

class Course

  attr_accessor :name, :department, :credits, :time_block, :days_of_week

  def initialize(name, department, credits, time_block, days_of_week)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @time_block = time_block
    @days_of_week = days_of_week
  end

  def add_student(student)
    if not @students.include?student
      student.enroll(self)
      @students << student
    end
  end

  def conflicts_with?(course)
    day_conflict = false
    time_conflict = (self.time_block == course.time_block)
    self.days_of_week.each do |day|
      day_conflict = true if course.days_of_week.include?(day)
    end

    day_conflict || time_conflict
  end

end

if __FILE__ != $PROGRAM_NAME

  microbiology = Course.new("microbiology", "biology", 3, 1, [:mon, :wed, :fri])
  basic_physics = Course.new("physics 101", "physics", 4, 2, [:tues, :thurs])
  quantum_physics = Course.new("quantum effects", "physics", 3, 2, [:mon, :wed, :thurs])

  john = Student.new("John", "Doe")
  mary = Student.new("Mary", "Jane")

  microbiology.add_student(mary)
  p mary.course_load

  microbiology.add_student(john)
  john.enroll(basic_physics)
  john.enroll(quantum_physics)
  p john.course_load

end


#Q2
=begin
et's write a Tic-Tac-Toe game!

You should have a Board class and a Game class. The board should have methods like #won?, winner, empty?(pos), place_mark(pos, mark), etc.
The Game class should have a play method that loops, reading in user moves. When the game is over, exit the loop.
You should have a class that represents a human player (HumanPlayer), and another class for a computer player (ComputerPlayer). Start with the human player first.
Both HumanPlayer and ComputerPlayer should have the same API; they should have the same set of public methods. This means they should be interchangeable.
Your Game class should be passed two player objects on instantiation; because both player classes have the same API, the game should not know nor care what kind of players it is given.
Keep the computer AI simple: make a winning move if available; else move randomly.
Get a TA to review your work and make suggestions!
=end

class Board

  def self.board_layout
    Array.new(3) { Array.new(3) {' '} }
  end

  def initialize(board_layout = Board.board_layout)

    @board = board_layout
    @winner = nil
  end

  def won?
    # check if diagonal winning
    case
    when ([@board[0][0],@board[1][1],@board[2][2]].uniq.size == 1 and
          @board[1][1] != ' ' )
      @winner = @board[1][1]
      return true
    when ( [@board[0][2],@board[1][1],@board[2][0]].uniq.size == 1  and
          @board[1][1] != ' ' )
      @winner = @board[1][1]
      return true
    end

    #Check Horizontal winnings
    @board.each do |row|
      if row.all? {|ele| ele == row[0]} and row[0] != ' '
        @winner = row[0]
        return true
      end
    end

    #Check Vertical winnings
    (0..2).each do |index|
      if ( [@board[0][index],@board[1][index],@board[2][index]].uniq.size ==1 and
          @board[0][index] != ' ' )
        @winner = @board[0][index]
        return true
      end
    end

    return false
  end

  def winner
    @winner
  end

  def empty?(pos)
    @board[pos[0]][pos[1]] == ' '
  end

  def place_mark(pos, mark)
    @board[pos[0]][pos[1]] = mark
  end

  def render
    @board.each do |row|
      row.each { |cell| print "| #{cell} | " }
      print "\n"
    end
  end

  def full?
    @board.each do |row|
      row.each {|cell| return false if cell == ' '}
    end
    return true
  end

  def dup
    Board.new(@board.dup.map(&:dup))
  end
end

class TicTac
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new("X")
    @player2 = ComputerPlayer.new("O")
    @current_player = @player1
    # Say a thing about the game, print initial game board
    puts "This is a game of tic-tac-toe"
    self.start
  end

  def start
    while !(@board.won?) and !(@board.full?)

      @board.render
      puts "It is #{@current_player.class}'s Turn:"
      @current_player.make_move(@board)

      switch_player
    end
    @board.render
    if @board.full?
      puts "It's a tie game! Better luck next time :)"
    else
      puts "We Have A Winner!!"
      print "Winner is player #{@board.winner}"
    end
  end

  private

    def switch_player
      if @current_player == @player1
         @current_player = @player2
      else
         @current_player = @player1
      end
    end
end

class Player

  def initialize(mark)
    @mark = mark
  end

  def make_move(board)
    # To be implemented on player level
  end

  private

    def legal_move?(board, position)
      board.empty?(position)
    end
end

class HumanPlayer < Player

  def make_move(board)
    puts "enter a position format: 'x y'"
    pos = process_input(gets.chomp)

    while !legal_move?(board, pos)
      puts 'That is an invalid spot! (occupied or not empty)'
      puts "enter a position format: 'x y'"
      pos = process_input(gets)
    end

    board.place_mark(pos, @mark)
    puts "#{self.class} makes a mark at #{pos}"
  end

  private

    def process_input(input)
      input.strip.split(' ').map(&:to_i)
    end
end

class ComputerPlayer < Player

  def make_move(board)
    # check if there are winning solutions
    if winning_pos(board)
      board.place_mark(winning_pos(board), @mark)
      puts "#{self.class} makes a mark at #{winning_pos(board)}"
    else
      pos = [[0,1,2].sample, [0,1,2].sample]

      while !legal_move?(board, pos)
        pos = [[0,1,2].sample, [0,1,2].sample]
      end

      board.place_mark(pos, @mark)
      puts "#{self.class} makes a mark at #{pos}"
    end
  end

  private
    def winning_pos(board)
      available_pos = []

      3.times do |i|
        3.times do |j|
          available_pos << [i,j] if board.empty?([i,j])
        end
      end

      available_pos.each do |cell|
        new_board = board.dup
        new_board.place_mark(cell, @mark)
        return cell if new_board.won?
      end

      false
    end
end

if __FILE__ == $PROGRAM_NAME

end

