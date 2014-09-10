if __FILE__ == $PROGRAM_NAME
  def num_to_s(num, base)
    if num == 0
      converted = "0"
    else
      converted = ""
    end
    while num != 0
      converted += (num % base).to_s
      num -= num % base
      num /= base
    end
    return converted.reverse
  end
  p num_to_s(234, 2)
  p num_to_s(234, 10)
end