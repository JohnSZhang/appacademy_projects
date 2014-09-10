if __FILE__ == $PROGRAM_NAME
  class MyHashSet
    def initialize
      @store = {}
    end

    def insert(el)
      @store[el] = true
    end

    def include?(el)
      return @store[el] ? true : false
    end

    def delete(el)
      if self.include? el
        @store[el] = nil
        return true
      else
        return false
      end
    end

    def to_a
      array = []
      @store.each do |key, value|
        if value==true
          array.push(key)
        end
      end
      return array
    end

    def union(set2)
      return_set = MyHashSet.new
      @store.each do |key, value|
        if(value==true)
          return_set.insert(key)
        end
      end
      set2.to_a.each do |key|
        if (not self.include? key)
          return_set.insert(key)
        end
      end
      return return_set
    end

    def intersect(set2)
      return_set = MyHashSet.new
      @store.each do |key, value|
        if set2.include? key
          return_set.insert(key)
        end
      end
      return return_set
    end

    def minus(set2)
      return_set = self
      @store.each do |key, value|
        if set2.include? key
          return_set.delete(key)
        end
      end
      return return_set
    end

  end

  scientists = MyHashSet.new
  scientists.insert("Newton")
  scientists.insert("Curie")
  scientists.insert("AlJazeera")
  scientists.insert("good enough")

  english_speakers = MyHashSet.new
  english_speakers.insert("Newton")
  english_speakers.insert("Curie")
  english_speakers.insert("Shakespeare")

  scientists.delete("good enough")
  p scientists.to_a
  p scientists.intersect(english_speakers).to_a
  p scientists.union(english_speakers).to_a
  p scientists.to_a
  p scientists.intersect(english_speakers).to_a
  p scientists.minus(english_speakers).to_a
end