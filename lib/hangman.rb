#Hangman Game
#Player versus the Computer.
#5desk.txt is the dictionary.

require 'yaml'

class Hangman
  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
    puts ""
    puts "Welcome to the Hangman game!"
    puts "You will be playing against the computer!"
    @player.start
  end

end #End of Hangman class

class Player
  def initialize
    @guesses = []
    @wrong_guesses_left = 1
    @player_correct_guesses = []
    @incorrect_words = []
    @secret_word = []
  end

  def start
    puts ""
    puts "Would you like to load a game? (yes/no)"
    player_load_game = gets.chomp.downcase
    case player_load_game
      when "yes"
        load_game
      when "no"
        puts "Please enter your name: "
        name = gets.chomp
        puts "Welcome #{name}."
        puts "You may save your game at any time by typing (save)"
        Computer.pick_word
        @secret_word = Computer.check_word
        @turn = 1
        create_board
        guess
    else
      puts "Please enter a valid input."
    end
  end

  def create_board
    # if @player_correct_guesses.empty?
        @secret_word.length.times { |x| @player_correct_guesses << " _ " }

  #  end
  end

  def guess_scan_answer
    @secret_word.include?@player_guess.to_s
  end

  def return_index
    @secret_word.each_with_index.map do |x, index|
      if x == @player_guess
        @player_correct_guesses.delete_at(index)
        @player_correct_guesses.insert(index, @player_guess)
      end
    end
  end


  def guess_check
    if guess_scan_answer
      puts "Your letter guess (#{@player_guess}) was correct!"
      #@player_correct_guesses << @player_guess
      return_index
      puts ""
      #p @player_correct_guesses #check
      #p @player_guess#check
      check_win
    else
      check_lose
      puts "\nWrong guess! [#{@wrong_guesses_left}] wrong guesses"
      @total_wrong_left = 7 - @wrong_guesses_left
      @incorrect_words.push(@player_guess)
      puts "You have #{@total_wrong_left} wrong guesses left"
      puts "The incorrect words you have used are: #{@incorrect_words}"
      puts ""
      @wrong_guesses_left += 1
      #p @player_correct_guesses#check
      #p @player_guess#check
      guess
    end
  end

  def check_lose
    if @wrong_guesses_left == 7
      puts "Sorry! You ran out of guesses! You LOSE! :("
      @player_correct_guesses = Array.new
      play_again
    end
  end

  def play_again
    puts "Would you like to play again (yes/no)"
    rematch = gets.chomp.downcase
    if rematch == "yes"
      @player_correct_guesses = []
      start
    elsif rematch == "no"
      puts "Okay! Maybe next time! Goodbye!"
      exit
    else
      puts "Please enter a valid response."
      play_again
    end
  end

  def check_win
    if @player_correct_guesses == @secret_word
      puts "You WIN! You guessed it correctly!"
      puts ""
      puts "The word was..... "
      print "#{@secret_word.join}\n"
      play_again
    else
      guess
    end
  end

  def guess
    puts ""
    puts "Your current board:"
    puts "#{@player_correct_guesses.join(" ")}"
    puts "Incorrect words: #{@incorrect_words}"
    puts "Turn ##{@turn}"
    print "Please enter a letter: "

    @player_guess = gets.chomp.downcase
    @turn += 1
      if @player_guess == "save"
        save_game
      else
      guess_check
    end
  end #End of guess method


  def save_game
    #yaml = YAML::dump(self)
    puts "Please enter a filename for the saved game."
    save_file_name = gets.chomp.downcase
    save_file = File.write("saved_games/#{save_file_name}.yaml", self.to_yaml)
    #save_file.write(yaml)
    puts "Your game has been saved!"
    puts "Goodbye!"
  end


  def load_game
  saved_games = check_files
  puts "Please input the FILENAME for the saved game."
  load_file_name = gets.chomp.downcase
  yaml = "saved_games/#{load_file_name}.yaml"
    if saved_games.include?(yaml)
      YAML.load_file(yaml).guess
    else
      puts "Sorry, this file does not exist!"
      start
    end
  end

  def check_files
    saved_games = Dir.glob("saved_games/*")
    if saved_games.empty?
      puts "There are no saved files."
      start
    end
    puts "Your saved games are: #{saved_games}"
    saved_games
  end

end #End of Player class


class Computer
  attr_reader :secret_word
  def initialize
    @secret_word = secret_word
  end

  def self.pick_word
    puts "The computer is now choosing a word..."
    sleep 0.5
    puts ""
    print "The computer has now chosen a word. "
#This block of code will assign a random word(5-12 length) to the secret_word array
    loop do
    @secret_word = File.readlines("5desk.txt").sample.chomp
    break if @secret_word.length > 5 && @secret_word.length < 12
    end  #until @secret_word.length > 5 && @secret_word.length < 12
    #puts @secret_word #displays the answer
    print "The length of the word is: #{@secret_word.to_s.length}\n" #Delete this after finished project.
  end #End of pick_word


  def self.check_word
    #  if @secret_word.nil?
    #    YAML.load_file(show_file_yaml)
    #  else
      @secret_word.downcase.split(//)
  #  end
  end

end #End of Computer Class

game = Hangman.new
game.start
