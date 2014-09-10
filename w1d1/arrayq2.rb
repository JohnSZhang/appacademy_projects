if __FILE__ == $PROGRAM_NAME
  class Array
    def two_sum
      positions = []
      for i in 0...self.length
        for j in i+1...self.length
          if self[i] + self[j] == 0
            positions << [i,j]
          end
        end
      end
      return positions
    end
  end
  p [-1, 0, 2, -2, 1].two_sum
end