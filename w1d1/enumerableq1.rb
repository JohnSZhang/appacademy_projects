if __FILE__ == $PROGRAM_NAME
  class Array
    def double_array
      double_array = []
      self.each do |num|
        double_array.push(2*num)
      end
      return double_array
    end
  end
  test = [1,3,5]
  p test.double_array
end