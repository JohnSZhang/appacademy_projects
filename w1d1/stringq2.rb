if __FILE__ == $PROGRAM_NAME
  def caesar(word, key)
    cipher_text = ''
    word = word.split(//)
    word.each do |letter|
      letter = letter.ord
      letter += key
      letter = (letter - 96)%26 + 96
      letter = letter.chr
      cipher_text += letter
    end
    return cipher_text
  end
  p caesar("hello", 3)
end