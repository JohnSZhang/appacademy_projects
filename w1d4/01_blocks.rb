class Array
  def my_each
    self.length.times do |index|
      yield self[index]
    end

    self
  end

  def my_map(&block)
    result = []
    self.my_each do |el|
      result << block[el]
    end

    result
  end

  def my_select(&block)
    result = []
    self.my_each do |el|
      result << el if block[el]
    end

    result
  end

  def my_inject(&block)
    inject_array = self.dup
    results = inject_array.shift

    inject_array.my_each do |el|
      results = block[results, el]
    end

    results
  end

  def my_sort!(&block)
    sorted = false
    while ! sorted
      sorted = true
      (self.length-1).times do |index|
        if block.call(self[index], self[index+1]) > 0
          self[index], self[index+1] = self[index+1], self[index]
          sorted = false
        end
      end
    end
    self
  end

  def my_sort(&block)
   self.dup.my_sort!(&block)
  end
end

def eval_block(*args)
  unless block_given?
    puts "NO BLOCK GIVEN"
    return
  end
  yield(*args)
end

