#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  duped = array.dup
  return duped.pop if duped.length == 1
  duped << duped.pop + duped.pop
  sum_recur(duped)
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.empty?
  duped = array.dup
  return true if duped.pop == target
  includes?(duped, target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  return array.length if array.all?{|el| el == target}
  duped = array.dup
  if duped.shift == target
    duped << target
  end
  num_occur(duped, target)

end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  duped = array.dup
  return true if duped.pop + duped.last == 12
  add_to_twelve?(duped)
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  return [] if array.empty?
  return true if array.length < 2
  duped = array.dup
  return false if duped.pop < duped.last
  sorted?(duped)
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  return number if number < 10
  numstring = number.to_s
  first_digit = numstring.slice!(0)
  last_digit = numstring.slice!(-1)
  (last_digit + reverse(numstring.to_i).to_s + first_digit).to_i
end

