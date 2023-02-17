require_relative 'display'
require_relative 'serialize'

class Hangman
  include Display
  include Serialize
  attr_accessor :word, :turns, :display_word, :current_player_guess, :correct_guess, :incorrect_guess

  def initialize (turns = 10)
    @word = random_word
    @turns = turns
    @display_word = ''
    @current_player_guess = ''
    @correct_guess = []
    @incorrect_guess = []
  end

  def random_word
    word_data = File.open('google-10000-english-no-swears.txt')
    word_array = word_data.filter { |word| word.length > 5 && word.length < 13}
    word_array.sample.chomp
  end

  def player_input
    loop do
      player_guess = gets.chomp
      if player_guess.match?(/^[a-z]$/)
        self.current_player_guess = player_guess
        player_input_duplicate
        return player_guess
      else
        puts "INVALID INPUT"
      end
    end
  end

  def player_input_duplicate
    if correct_guess.include?(current_player_guess) || incorrect_guess.include?(current_player_guess)
      self.turns += 1
      puts "already guessed #{current_player_guess}"
    end
  end

  def char_match_word(player_char) 
    idx = []
    word.split('').each_with_index do |word_char, word_index|
      if player_char == word_char
        if !correct_guess.include?(player_char)
          self.turns += 1
          correct_guess.push(player_char)
        end
        idx.push(word_index)
      end
    end
    if !word.include?(player_char)
      if !incorrect_guess.include?(player_char)
        incorrect_guess.push(player_char)
      end
    end
    idx
  end

  def check_win
    if word.split('') == display_word.split(' ')
      puts "YOU WIN!"
      puts display_word
      self.turns = 0
    end
    if turns == 0
      puts "YOU LOSE! The word was #{word}"
    end
  end

  def start_game
    display
    while turns.positive?
      puts display_word
      puts "guess a letter / turns left: #{turns}\n\n"
      player_guess_to_display(char_match_word(player_input)) #have function to check
      self.turns -= 1
      check_win
    end
  end

  def save_game
    serialize_save(word, turns, display_word, current_player_guess, correct_guess, incorrect_guess)
    puts 'file saved'
  end

  def load_game(target)
    serialize_load(target)
    puts 'file loaded'
  end
end

new_game = Hangman.new
#new_game.start_game
#new_game.save_game
new_game.load_game('2023-02-16 20:25:43 -0500')