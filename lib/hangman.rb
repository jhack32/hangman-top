#Hangman Game
#Player versus the Computer.
#5desk.txt is the dictionary.


class Hangman
  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
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
  end

  def start
    puts "Please enter your name: "
    name = gets.chomp
    puts "Welcome #{name}."
    Computer.pick_word
    @turn = 1
    create_board
    guess
  end

  def create_board
    # if @player_correct_guesses.empty?
        Computer.check_word.length.times { |x| @player_correct_guesses << " _ " }
        print @player_correct_guesses.to_s + "\n"
  #  end
  end

  def guess_scan_answer
    Computer.check_word.include?@player_guess.to_s
  end

  def return_index
    Computer.check_word.each_with_index.map do |x, index|
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
      p @player_correct_guesses #check
      p @player_guess#check
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
      p @player_correct_guesses#check
      p @player_guess#check
      guess
    end
  end

  def check_lose
    if @wrong_guesses_left == 7
      puts "Sorry! You ran out of guesses! You LOSE! :("
      puts ""
      @player_correct_guesses = Array.new
      play_again
    end
  end

  def play_again
    puts "Would you like to play again (yes/no)"
    rematch = gets.chomp.downcase
    if rematch == "yes"
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
    if @player_correct_guesses == Computer.check_word
      puts "You WIN! You guessed it correctly!"
      play_again
    else
      guess
    end
  end

  def guess
    puts ""
    puts "Turn ##{@turn}"
    print "Please enter a letter: "
    @player_guess = gets.chomp.downcase
    @turn += 1
    guess_check
  end #End of guess method

end #End of Player class


class Computer
  attr_reader :secret_word
  def initialize
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
    print @secret_word + " The length of the word is: #{@secret_word.to_s.length}\n" #Delete this after finished project.
  end #End of pick_word


  def self.check_word
    @secret_word.downcase.split(//)
  end

end #End of Computer Class

game = Hangman.new
game.start
