if __FILE__ == $PROGRAM_NAME
  class Array
    def median
      if self.length % 2 == 1
        return self[(self.length-1)/2]
      else
        return (self[self.length/2].to_f + self[(self.length/2)-1])/2
      end
    end
  end
end