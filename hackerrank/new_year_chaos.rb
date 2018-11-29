#!/bin/ruby

require 'json'
require 'stringio'
require 'set'
require 'benchmark'

class LinearAlgorithm

  def minimumBribes(q)
    bribes = 0
    intermediate_q = (1..q.size).to_a
    puts "\nFinal: #{q.inspect}" if $DEBUG
    q.size.times.each do |i|
      current_position = i + 1
      current_value = q[i]
      expected_value = intermediate_q[i]
      current_displacement = current_value - current_position
      new_bribes = 0

      if $DEBUG
        print "\t"
        print "current_position: #{current_position}, "
        print "current_value: #{current_value}, "
        print "expected_value: #{expected_value}, "
        print "current_displacement: #{current_displacement} "
        print "\n"
      end

      if current_displacement >= 3
        puts "Too chaotic"
        return

      elsif current_displacement >= 1
        new_bribes = current_displacement

      elsif current_value != expected_value         # non-positive displacement but unexpected value
        if current_value == intermediate_q[i + 1]
          current_displacement = 1
          new_bribes = current_displacement

        elsif current_value == intermediate_q[i + 2]
          current_displacement = 2
          new_bribes = current_displacement

        else
          puts "Too chaotic"
          return
        end
      end

      if (new_bribes > 0)
        bribes += new_bribes
        intermediate_q.delete_at(i + new_bribes)
        intermediate_q.insert(i, current_value)
        if $DEBUG
          puts "\t\t+#{new_bribes} bribes"
          puts "\t\tintermediate_q: #{intermediate_q.inspect}\n\n"
        end
      end
    end

    puts bribes
  end
end


class Bfs_Algorithm

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

  private

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
end



def minimumBribes(q)
  runtime = Benchmark.realtime {
    LinearAlgorithm.new.minimumBribes(q)
  }
  puts "\nTotal Runtime: #{runtime * 1000} ms (#{runtime} seconds)" if $DEBUG
end


t = gets.to_i
t.times do |t_itr|
  n = gets.to_i

  q = gets.rstrip.split(' ').map(&:to_i)

  minimumBribes q
end


