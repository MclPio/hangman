class Hangman
  attr_accessor :word, :turns

  def initialize (turns = 10)
    @word = random_word
    @turns = turns
  end

  def random_word
    word_data = File.open('google-10000-english-no-swears.txt')
    word_array = word_data.filter { |word| word.length > 5 && word.length < 13}
    word_array.sample.chomp
  end

  def display
    word_length = word.length
    array = []
    word_length.times {array.push('_')}
    array
  end

  def player_input
    loop do
      player_guess = gets.chomp
      if player_guess.match?(/^[a-zA-Z]$/)
        return player_guess
      else
        puts "INVALID INPUT"
      end
    end
  end
  def start_game
    while turns.positive?
      puts display.join(' ')
      puts "guess a letter / turns left: #{turns}"
      player_input
      self.turns -= 1
    end
  end
end

new_game = Hangman.new
new_game.start_game