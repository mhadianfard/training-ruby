class Greeter
  attr_accessor (:name)

  def initialize(name = "world")
    @name = name
  end

  def say_hi
    puts "Hello #{@name.capitalize}"
  end

  def say_bye

  end
end

greeter = Greeter.new
greeter.say_hi


