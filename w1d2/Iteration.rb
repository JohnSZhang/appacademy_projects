#Q1 Write a loop that finds the first number that is (a) >250 and (b) divisible by 7. Print this number!

def first_num
  init = 250
  while init % 7 != 0
    init += 1
  end
  print init
end

#Q2 Write a method factors that prints out all the factors of a given number.
def factors(number)
  factors = []
  (1..number).each {|num| factors << num if number % num == 0}
  factors
end

#Q3 Implement Bubble sort in a method #bubble_sort that takes an Array and modifies it so that it is in sorted order.
def bubble_sort(to_sort)
  sorted = false
  while sorted == false
    sorted = true
    (0...to_sort.length-1).each do |pos|
      if to_sort[pos] > to_sort[pos+1]
         to_sort[pos], to_sort[pos+1] = to_sort[pos+1], to_sort[pos]
         sorted = false
      end
    end
  end
  return to_sort
end


#Q4 Write a method substrings that will take a String and return an array containing each of its substrings. Don't repeat substrings. Example output: substrings("cat") => ["c", "ca", "cat", "a", "at", "t"].
require 'debugger'
def substrings(string)
  substrings = []
  (1..string.length).each do |string_length|
    (0...string.length).each do |string_position|
      next if string_position + string_length > string.length
      if not substrings.include?(string[string_position, string_length] )
        substrings << string[string_position, string_length]
      end
    end
  end
  substrings
end

#Q5 Your substrings method returns many strings that are not true English words. Let's write a new method, subwords which will call substrings, but then filter it and return just the English words.
def substrings_with_dictionary(string)
  dictionary = File.readlines('./dictionary.txt').map(&:strip)
  substrings = []
  (1..string.length).each do |string_length|
    (0...string.length).each do |string_pos|
      next if string_pos + string_length > string.length
      next unless dictionary.include?(string[string_pos, string_length].strip)
      if not substrings.include?(string[string_pos, string_length] )
        substrings << string[string_pos, string_length]
      end
    end
  end
  substrings
end


