#Hangman Game
#Player versus the Computer.
#5desk.txt is the dictionary.

#need to push correct words into proper positions.
#need to show incorrect words and correct words.
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
  end

  def start
    puts "Please enter your name: "
    name = gets.chomp
    puts "Welcome #{name}."
    Computer.pick_word
    puts "The computer has now chosen a word."
    @turn = 1
    guess
  end

  def display_board
      if @player_correct_guesses.empty?
        Computer.check_word.length.times { |x| @player_correct_guesses << " _ " }
        print @player_correct_guesses.to_s + "\n"
    end
  end

  def guess_scan_answer
    Computer.check_word.each do |x|
      x.include?@player_guess.to_s

    end
  end

  def guess_check
    if guess_scan_answer
      puts "Your letter guess (#{@player_guess}) was correct!"
      #@player_correct_guesses << @player_guess
      p @player_correct_guesses #check
      p @player_guess#check
      p Computer.check_word#check
      check_win
      board
    else
      puts "Wrong guess! [#{@wrong_guesses_left}] wrong guesses"
      @total_wrong_left = 7 - @wrong_guesses_left
      puts "You have #{@total_wrong_left} wrong guesses left"
      @wrong_guesses_left += 1
      p @player_correct_guesses#check
      p @player_guess#check
      puts Computer.check_word #check
      guess
    end
  end

  def check_win
    if @player_correct_guesses == Computer.check_word
      puts "You WIN! You guessed it correctly!"
      #play again method
    else
      guess
    end
  end

  def guess
    display_board
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
#This block of code will assign a random word(5-12 length) to the secret_word array
    loop do
    @secret_word = File.readlines("5desk.txt").sample.chomp
    break if @secret_word.length > 5 && @secret_word.length < 12
    end  #until @secret_word.length > 5 && @secret_word.length < 12
    puts @secret_word + " The length is: #{@secret_word.to_s.length}" #Delete this after finished project.
  end #End of pick_word


  def self.check_word
    @secret_word.downcase.split(//)
  end

end #End of Computer Class

game = Hangman.new
game.start
