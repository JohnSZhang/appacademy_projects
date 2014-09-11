def range(start_num, end_num)
  return [] if end_num < start_num
  range(start_num, end_num-1) << end_num
end

def iter_range(start_num, end_num)
  result = []
  (start_num..end_num).each do |num|
    result << num
  end
  result
end

def sum(array)
  duped_array = array.dup
  return 0 if duped_array.empty?
  duped_array.pop + sum(duped_array)
end

def iter_sum(array)
  sum = 0
  array.each do |num|
    sum += num
  end
  sum
end

def exp(b, n)
  return 1 if n == 0
  b * exp(b, n-1)
end

def square(n)
  return n * n
end

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return square(exp2(b, n/2)) if n.even?
  b * square(exp2(b, n-1 / 2))
end

class Array
  def deep_dup
    result = []
    self.each do |el|
      el.is_a?(Array) ? result << el.deep_dup : result << el
    end

    result
  end
end

def fibonacci(n)
  return [1, 1] if n == 2
  fibonacci(n-1) << fibonacci(n-1)[-1] + fibonacci(n-1)[-2]
end

def iter_fibonacci(n)
  result = [1, 1]
  (2...n).each do |i|
    result << result[i-1] + result[i-2]
  end
  result
end

def binary_search(array, target, beginning = 0)
  return nil if array.empty?
  midpoint = array.length / 2

  if target == array[midpoint]
    return beginning + midpoint
  elsif target < array[midpoint]
    binary_search(array[0...midpoint], target, beginning)
  else
    binary_search(array[midpoint+1..-1], target, beginning + midpoint + 1)
  end

end

#Given Solution So Far And Coin List, And Remainder, See if You Can Fit Biggest Coin

#If Remainder Is Zero, Return The Solution List

#If You Can Fit Biggest Coin, Do SO, Add To Solution, Pass Along CoinList And Remainder

#If Not, Remove Largest Coin From Coin List And Pass Down The Rest

def make_change_recursive(amount, coin_list, solution = [])
  return solution if amount == 0
  big_coin = coin_list[0]
  if amount >= big_coin
    make_change_recursive(amount - big_coin, coin_list, solution << big_coin)
  else
    make_change_recursive(amount, coin_list[1..-1], solution)
  end
end

def make_change(amount, coin_list)
  solutions = []
  (coin_list.length).times do |coin_index|
    solutions << make_change_recursive(amount, coin_list[coin_index..-1])
  end
  solutions.sort_by { |el| el.length }.first
end


class Array
  def merge_sort(list = self)
    return list if list.length <= 1
    midpt = list.length / 2
    left = list[0..midpt-1]
    right = list[midpt..-1]
    left = merge_sort(left)
    right = merge_sort(right)

    merge(left, right)
  end

  private
  def merge(left, right)
    result = []
    while !left.empty? || !right.empty?
      if left.length > 0 && right.length > 0
        if left.first <= right.first
          result << left.shift
        else
          result << right.shift
        end
      elsif left.length > 0
        result << left.shift
      elsif right.length > 0
        result << right.shift
      end
    end

    result
  end
  # Merge_Recursive method

  # If More Than Two Arguments, Divide and Conq

  # If Two Elements, Set A Return, Compare Ele's Index 0, Add Smaller To Result

  # If One Element Is null, Add First Element Of other to end of result

end

def subsets(array)
  return [[]] if array.empty?
  result = [array]
  array.each_with_index do |el, index|
    trimmed_array = array.dup
    trimmed_array.delete_at(index)
    p trimmed_array
    result += subsets(trimmed_array)
  end
  result.uniq
end
