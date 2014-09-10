class Fixnum
  def in_words
    case self
#single digits
    when 0
      return 'zero'
    when 1
      return 'one'
    when 2
      return 'two'
    when 3
      return 'three'
    when 4
      return 'four'
    when 5
      return 'five'
    when 6
      return 'six'
    when 7
      return 'seven'
    when 8
      return 'eight'
    when 9
      return 'nine'
    #tweens
    when 10
      return 'ten'
    when 11
      return 'eleven'
    when 12
      return 'twelve'
    when 13
      return 'thirteen'
    when 14
      return 'fourteen'
    when 15
      return 'fifteen'
    when 16
      return 'sixteen'
    when 17
      return 'seventeen'
    when 18
      return 'eighteen'
    when 19
      return 'nineteen'
    when 20
      return 'twenty'
    when 30
      return 'thirty'
    when 40
      return 'forty'
    when 50
      return 'fifty'
    when 60
      return 'sixty'
    when 70
      return 'seventy'
    when 80
      return 'eighty'
    when 90
      return 'ninety'
    when 21...100
      ones = self % 10
      tens = self - ones
      return tens.in_words + ' ' + ones.in_words
    when 100...1000
      hundreds = self / 100
      front_digits = self - 100 * hundreds
      if front_digits == 0
        return hundreds.in_words + " hundred"
      else
        return hundreds.in_words + " hundred " + front_digits.in_words
      end
    when 1000...1000000
      front_digits = self % 1000
      back_digits = self / 1000
      if front_digits == 0
        return back_digits.in_words + " thousand"
      else
        return back_digits.in_words + " thousand " + front_digits.in_words
      end
    when 1000000...1000000000
      millions_digits = self/1000000
      the_rest = self % 1000000
      if the_rest == 0
        return millions_digits.in_words + " million"
      else
        return millions_digits.in_words + " million " + the_rest.in_words
      end
    when 1000000000...1000000000000
      billions_digits = self/1000000000
      the_rest = self % 1000000000
      if the_rest == 0
        return billions_digits.in_words + " billion"
      else
        return billions_digits.in_words + " billion " + the_rest.in_words
      end
    when 1000000000000...1000000000000000
      trillions_digits = self/1000000000000
      the_rest = self % 1000000000000
      if the_rest == 0
        return trillions_digits.in_words + " trillion"
      else
        return trillions_digits.in_words + " trillion " + the_rest.in_words
      end
    else


      #when 21..29
      #return 'twenty-' + (self - 20).in_words
      #else
      #return ''
    end
  end
end
if __FILE__ == $PROGRAM_NAME
  p 29.in_words
end
