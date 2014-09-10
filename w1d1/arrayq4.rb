if __FILE__ == $PROGRAM_NAME
  class Array
    def my_transpose
      arrayT = []
      for i in 0...self.length
        arrayT.push []
      end
      for i in 0...self.length
        for j in 0...self.length
          arrayT[j].push self[i][j]
        end
      end
      return arrayT
    end
  end
  my_array = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
  print my_array.my_transpose
end

