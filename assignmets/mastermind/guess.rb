class Guess
  def initialize(guess)
    @guess = guess
  end

  def evaluate(code)
    code = code.clone
    guess = @guess.clone
    @white = 0
    @black = 0

    guess.each_with_index do |peg_color, peg_position|
      if peg_color == code[peg_position]
        @black += 1
        code[peg_position] = ""
        guess[peg_position] = nil
      end
    end

    guess.each do |peg_color|
      if code.include? peg_color
        @white += 1
        real_peg_position = code.index(peg_color)
        code[real_peg_position] = ""
      end
    end

    (@black == code.size)
  end

  def print_colors
    @guess.each { |c| print "  #{c} cd " }
  end

  def print_guess_number(number)
    print number.to_s.rjust(2, " ") + ": "
  end

  def print_results
    score = ""
    @black.times { score += "*" }
    @white.times { score += "-" }
    print "\t\t(#{score.ljust(@guess.size, " ")})"
  end
end