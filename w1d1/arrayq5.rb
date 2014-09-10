if __FILE__ == $PROGRAM_NAME
  class Array
    def stock_picker
      differences = []
      for i in 0...self.length-1
        differences << []
        for j in i...self.length
          differences[i].push self[j] - self[i]
        end
      end
      best = 0,0

      print differences
      print "\n"

      for i in 0...differences.length
        for j in 0...differences[i].length
          if differences[i][j] > differences[best[0]][best[1]-best[0]] then
            best = i,j+i
          end
        end
      end
      return best[0],best[1]+1
    end
  end
  stocks = [4, 2, 5]
  p stocks.stock_picker
end