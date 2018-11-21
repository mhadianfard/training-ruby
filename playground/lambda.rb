class MyClass
  def initialize
  end

  def as_lambda
    lambda {yield}
  end

  def as_proc
    Proc.new {yield}
  end

  def get_proc
    Proc.new do |a1|
      puts "returning a Proc"
      return if a1.nil?
      a1 + " processed by Proc."
    end
  end

  def myMethod (something = nil)
    puts "-------"
    returnedValue = get_proc.call something
    puts "other stuff in my method"
    puts "by the way, returned value was \"#{returnedValue}\""
  end

  def returnInBlock(int)
    puts "some stuff to start"
    returnValue = yield int
    puts "returnValue was \"#{returnValue}\""
    puts "some stuff to finish"
  end
end


myClass = MyClass.new
myClass.returnInBlock 50 do |i|
  if i > 10
    return "more than 10"
  elsif i > 20
    return "more than 20"
  end
  "end of block"
end

lambda = myClass.as_lambda { print "This should be a lambda. " }
proc = myClass.as_proc { print "This should be a proc. " }

lambda.call
puts lambda.inspect

proc.call
puts proc.inspect

myClass.myMethod "this is the argument"

puts "\nHere's what happens with no argument:"
myClass.myMethod