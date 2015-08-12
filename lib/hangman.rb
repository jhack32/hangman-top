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
  end

  def start
    puts "Please enter your name: "
    name = gets.chomp
    puts "Welcome #{name}."
    Computer.pick_word

  end

end #End of Player class


class Computer
  attr_accessor :secret_word
  def initialize
    @secret_word = []
  end

  def self.pick_word
    puts "The computer is now choosing a word..."
    sleep 0.5
#This block of code will assign a random word(5-12 length) to the secret_word array
    begin
    @secret_word = File.readlines("5desk.txt").sample
    end until @secret_word.length > 5 && @secret_word.length < 12

    puts @secret_word + " #{@secret_word.length}" #Delete this after finished project.
  end
end




game = Hangman.new
game.start
