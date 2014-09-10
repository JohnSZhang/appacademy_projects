if __FILE__ == $PROGRAM_NAME
  class Array
    def my_each(&block)
      for i in 0...self.length
        block.call(self[i])
      end
      return self
    end
  end
  return_value = [1, 2, 3].my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end
end
