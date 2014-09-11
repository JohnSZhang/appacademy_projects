class Array
  def my_each(&block)
    self.length.times do |el|
      block[self[el]]
    end
    return self
  end
end

