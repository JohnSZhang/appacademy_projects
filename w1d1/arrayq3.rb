if __FILE__ == $PROGRAM_NAME

  def towers_of_hanoi
    print "What size should the pile be? \n"
    size = gets
    size = size.chomp.to_i
    piles = [(1..size).to_a.reverse,[],[]]
    while piles[2] != (1..size).to_a.reverse
      print "piles : " + piles.to_s + "\n"
      print "move from pile:"
      from_pile = gets
      print "\n move to def pile : "
      to_pile = gets

      from_pile = from_pile.chomp.to_i - 1
      to_pile = to_pile.chomp.to_i - 1

      if not piles[from_pile].empty?
        if piles[to_pile].empty? or piles[from_pile].last < piles[to_pile].first
          piles[to_pile] << piles[from_pile].pop
        else
          print " \n redo!!!"
          next
        end
      end
    end
    print "\n you win. yayyy. here's a cookie. =D"
  end
  towers_of_hanoi
end