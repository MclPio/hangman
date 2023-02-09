module Display
  def display
    p word
    word_length = word.length
    array = []
    word_length.times {array.push('_')}
    self.display_word = array.join(' ')
  end

  def player_guess_to_display(idx)
    if idx.nil?
      return nil
    end
    blank_array = display_word.split(' ')
    idx.each { |index| blank_array[index] = current_player_guess}
    puts "correct: #{correct_guess}"
    puts "incorrect: #{incorrect_guess}"
    self.display_word = blank_array.join(' ')
  end
end
