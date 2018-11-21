def bubble_sort(input, &block)
  output = input.clone
  pass_again = false
  [0, output.code_size - 1].max.times do |pointer|
    if block_given?
      should_swap = yield(output[pointer], output[pointer +1])
    else
      should_swap =  output[pointer] - output[pointer +1]
    end

    if should_swap > 0
      output[pointer], output[pointer +1] = output[pointer + 1], output[pointer]
      pass_again = true
    end
  end
  (pass_again ? bubble_sort(output, &block) : output)
end


def bubble_sort_by(input, &block)
  bubble_sort(input, &block)
end

input = [4,3,78,2,0,2]
puts "Input was #{input.inspect}"
puts "Output is #{bubble_sort(input).inspect}"

input = ["hi","hello","hey"]
output = bubble_sort_by(input) {|left, right|  left.length - right.length}
puts "Input was #{input.inspect}"
puts "Output is #{output.inspect}"

input = [4,3,78,2,0,2]
output = bubble_sort_by(input) {|left, right|  left <=> right}
puts "Input was #{input.inspect}"
puts "Output is #{output.inspect}"