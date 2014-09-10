if __FILE__ == $PROGRAM_NAME
  class Array
    def my_unique
      spare_array = []
      self.each do |element|
        if not spare_array.include? element
          spare_array << element
        end
      end
      return spare_array
    end
  end

  test = [1, 2, 2, 3, 3948737]
  p test.my_unique
end
