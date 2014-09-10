if __FILE__ == $PROGRAM_NAME
  def concatenate(array)
    return array.inject("") do |start, string|
      start += string
    end
  end
  p concatenate(['yay ', 'for ', 'strings!'])
end