require 'set'

class WordChainer
  def initialize(filename)
    @dictionary = Set.new(File.readlines(filename).map(&:chomp))
  end

  def adjacent_words(word)
    adjacent = Set.new
    @dictionary.each do |item|
      adjacent << item if one_letter_off?(word, item)
    end

    adjacent
  end

  def one_letter_off?(word1, word2)
    return nil if word1.length != word2.length || word1 == word2
    diffs = 0
    word1.chars.each_with_index do |char, index|
      diffs += 1 if word2[index] != char
    end

    diffs == 1
  end

  def run(source, target)
    @current_words = Set.new([source])
    @all_seen_words = {source => nil}

    until @current_words.empty?
      explore_current_words(target)
    end
    @all_seen_words[source] = nil

    build_path(target).reverse
  end

  def build_path(target, path = [])
    return path if target.nil?
    path << target
    build_path(@all_seen_words[target], path)
  end

  def print_word_chain
    @current_words.each do |word|
      puts "current word: #{word} from #{@all_seen_words[word]}"
    end
  end

  def print_all_seen_words
    @all_seen_words.each do |k, v|
      puts "#{k} from #{v}"
    end
  end

  def explore_current_words(target)
    new_current_words = Set.new

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words[adjacent_word]
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
        if @all_seen_words[target]
          @current_words = new_current_words
          return
        end
      end
    end

    @current_words = new_current_words
    nil
  end

end