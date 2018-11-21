def myFunction
  myVar = 2020
  myVar2 = 33
  puts ">- Starting myFunction"
  if block_given?
    yield myVar, myVar2
  else
    puts ">- [no block provided]"
  end
  puts ">- Ending myFunction"
  puts "-----------------"
  puts
end

puts "Starting execution..."

myFunction { |dummy| puts dummy }

myFunction do |dummy1, dummy2|
  puts "line 1 of 2: #{dummy1}"
  puts "line 2 of 2: #{dummy2}"
end

myFunction