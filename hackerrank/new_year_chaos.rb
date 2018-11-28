#!/bin/ruby

require 'json'
require 'stringio'
require 'set'


# Complete the minimumBribes function below.
def minimumBribes(q)

  unless is_valid?(q)
   puts "Too chaotic"
   return
  end

  bribes = 0
  final_q = q.join
  starting_q = (1..final_q.length).to_a.join
  visited = Set.new
  queue = Array.new
  queue.push(starting_q)

  until queue.empty?
   new_queue = Array.new
   until queue.empty?
     arrangement = queue.shift
     if arrangement == final_q
       # found the final arrangement
       puts bribes
       return

     elsif !visited.include? arrangement
       visited.add(arrangement)
       new_queue.concat(get_all_possible_bribes(arrangement))
     end
   end
   queue = new_queue
   bribes += 1
  end
end


def is_valid?(q)
  q.each_with_index do |value, index|
    if (value > index + 3)
      # no person could have advanced more than 2 positions.
      return false
    end
  end
  true
end

def get_all_possible_bribes(q_str)
  possibilities = Array.new
  already_swapped = Set.new
  loop do
    did_swap = false
    new_q_str = q_str.clone
    new_q_str.length.times do |n|
      index = (new_q_str.length - 1) - n
      value = new_q_str[index].to_i

      if (value < index + 3) && (index > 0) && (!already_swapped.include? value)
        new_q_str[index-1], new_q_str[index] = new_q_str[index], new_q_str[index-1]  #swap!
        already_swapped.add(value)
        possibilities.push(new_q_str)
        did_swap = true
        break
      end
    end
    break unless did_swap
  end
  possibilities
end

# puts "T1: "; minimumBribes([1, 2, 3, 4, 5]);
# puts "T2: "; minimumBribes([1, 2, 4, 3, 5]);
# puts "T3: "; minimumBribes([1, 4, 2, 3, 5]);
# puts "T4: "; get_all_possible_bribes([4, 1, 2, 3, 5]);

# q = [1, 2, 3, 4, 5].join
# puts q.inspect
# get_all_possible_bribes(q).each do |p1|
#   puts
#   puts "\t#{p1.inspect}"
#   get_all_possible_bribes(p1).each do |p2|
#     puts
#     puts "\t\t#{p2.inspect}"
#     get_all_possible_bribes(p2).each do |p3|
#       puts "\t\t\t#{p3.inspect}"
#     end
#   end
# end

t = gets.to_i

t.times do |t_itr|
  n = gets.to_i

  q = gets.rstrip.split(' ').map(&:to_i)

  minimumBribes q
end
