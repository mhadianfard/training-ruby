module Enumerable
  def my_each
    index = 0
    while index < self.length
      yield(self[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    index = 0
    while index < self.length
      yield(self[index], index)
      index += 1
    end
    self
  end

  def my_select
    selections = []
    self.my_each do |item|
      selections << item if yield(item)
    end
    selections
  end

  def my_all?
    all_true = true
    self.my_each do |item|
      all_true &&= yield(item)
    end
    all_true
  end

  def my_any?
    any_true = false
    self.my_each do |item|
      any_true ||= yield(item)
    end
    any_true
  end

  def my_inject(*args)
    skip_first = false
    symbol = nil
    if args.size == 2
      initial = args[0]
      symbol = args[1]

    elsif args.size == 0
      initial = self[0]
      skip_first = true

    elsif args[0].class == Symbol
      initial = self[0]
      symbol = args[0]
      skip_first = true

    else
      initial = args[0]
    end
    
    memo = initial
    self.my_each_with_index do |item, index|
      unless index == 0 && skip_first
        if symbol
          memo = memo.method(symbol).call(item)
        else
          memo = yield(memo, item)
        end
      end
    end
    return memo
  end
end

input = [4, 5, 8, 10]
input2 = [2, 4, 6, 8]

input.my_each {|item| print "#{item}, "}
puts

input.my_each_with_index {|item, i| print "#{i}: #{item}, "}
puts

print "Evens: "
puts input.my_select {|item| item.even? }.inspect

print "#{input.inspect} All Even? "
puts input.my_all? {|item| item.even? }.inspect

print "#{input2.inspect} All Even? "
puts input2.my_all? {|item| item.even? }.inspect

print "#{input.inspect} Any Odd? "
puts input.my_any? {|item| item.odd? }.inspect

print "#{input2.inspect} Any Odd? "
puts input2.my_any? {|item| item.odd? }.inspect

puts
puts

print "SUM: "
print input.my_inject {|memo, item| memo + item}
print " vs. "
print input.inject {|memo, item| memo + item}
print " vs. "
print input.my_inject(:+)
print " vs. "
print input.inject(:+)
puts

print "MULT: "
print input.my_inject {|memo, item| memo * item}
print " vs. "
print input.inject {|memo, item| memo * item}
print " vs. "
print input.my_inject(:*)
print " vs. "
print input.inject(:*)
puts

print "SUM (init 100): "
print input.my_inject(100) {|memo, item| memo + item}
print " vs. "
print input.inject(100) {|memo, item| memo + item}
print " vs. "
print input.my_inject(100, :+)
print " vs. "
print input.inject(100, :+)
puts

print "MY MULT (init 100): "
print input.my_inject(100) {|memo, item| memo * item}
print " vs. "
print input.inject(100) {|memo, item| memo * item}
print " vs. "
print input.my_inject(100, :*)
print " vs. "
print input.inject(100, :*)
puts

