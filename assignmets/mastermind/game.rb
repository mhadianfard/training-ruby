require_relative 'guess'

class Game
  @@colors = %w(R G B Y)
  @@code_size = 5
  @@guesses_allowed = 12

  def initialize
    @code = get_new_code
    print_instructions
  end

  def start
    guesses_count = 0
    while guesses_count < @@guesses_allowed
      guess = get_next_guess
      if guess
        guesses_count += 1
        game_won = guess.evaluate(@code)

        print "\t\t\t\t"
        guess.print_guess_number(guesses_count)

        print "\t"
        guess.print_colors
        guess.print_results
        puts
      end
      if game_won
        print_congrats
        return
      end
    end
    print_gameover
  end

  private
    def print_instructions
      puts
      puts "Welcome to MasterMind"
      puts "=====================\n"
      puts "You have to guess our color code!"
      puts "Available Colours: #{@@colors.join(", ")}"
      puts
      puts "Scoring:"
      puts " * means a color and it's location are correct"
      puts " - means you have the correct color but not location"
      puts "Get all stars within #{@@guesses_allowed} guesses, to win the game!"
      puts
      puts "Start by entering #{@@code_size} colors separated by spaces."
      puts
      print "Secret: \t\t\t\t"
      mask = Array.new(@@code_size, "X")
      secret = Guess.new(mask)
      secret.print_colors
      puts
      puts
    end

    def print_congrats
      puts
      puts "Congratulations!  You cracked the code :)"
      puts
    end

    def print_gameover
      puts
      puts "You're out of turns."
      print "The code was:  \t\t\t\t"
      code = Guess.new(@code)
      code.print_colors
      puts
      puts "Better luck next time!"
      puts
      puts
    end

    def get_new_code
      code = Array.new(@@code_size)
      code.size.times do |index|
        random = Random.new
        color = random.rand(0..@@colors.size - 1)
        code[index] = @@colors[color]
      end
      code
    end

    def get_next_guess
      print "Your next guess > "
      input = gets.chomp!.upcase.gsub(' ', '').gsub(',','')
      guess = input.split(//)
      unless guess.size == @@code_size
        puts " You need to enter #{@@code_size} colors."
        puts
        return nil
      end

      unknown_colours = guess - @@colors
      unless unknown_colours.size == 0
        puts " I don't recognize #{unknown_colours.uniq.inspect} as colours."
        puts
        return nil
      end
      Guess.new(guess)
    end
end

game = Game.new
game.start

