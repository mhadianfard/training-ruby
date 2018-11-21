require 'set'
require 'benchmark'

# Debug will toggle output and testing
# debug = 1  basic standard output
# debug = 2  run test cases + level 1
$debug = 2

# Class used to store value of perfect squares used in a sum.
# Mostly useful to keep track of path of additions in the tree.
#
class Node

  # @param {Integer} value , value of this node - should be a perfect square.
  # @param {Node} parent, references the node in the tree that was considered before this Node
  # @param {Integer} sum, carries a mathematical sum of this Node's value and it's parent's sum
  #
  attr_reader :value, :parent, :sum

  # Constructor for the node
  # @param {Integer} value, value of this node - should be a perfect square.
  # @param {Node} parent (optional, default = nil)
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @sum = @parent&.sum.to_i + @value
  end

  # Will return an array of Nodes starting with the current,
  # all the way to the starting Node
  # @return {Array}
  #
  def get_playback
    playback = Array.new
    parent = self
    until parent.nil? do
      playback.push parent
      parent = parent.parent
    end
    playback
  end
end

# @param {Integer} n, input of program
# @return {Integer} number of perfect square additions resulting in n
#
def num_squares(n)
  squares = get_squares(n)
  if squares.last == n
    perfect_sqr_count = 1
    if $debug >= 1
      puts "Solution to n=#{n} is a perfect square already."
    end
    return perfect_sqr_count
  end

  perfect_sqr_count = 2
  nodes = squares.map{|sqr| Node.new(sqr)}
  checked_sums = Set.new
  until nodes.empty?
    next_nodes = Array.new
    nodes.each do |node|
      squares.each do |sqr|
        new_node = Node.new(sqr, node)
        if new_node.sum == n
          if $debug >= 1
            playback = new_node.get_playback
            puts "Found solution to n=#{n} with #{perfect_sqr_count} square additions:"
            puts "\t #{(playback.map{|node| node.value}).join(' + ')}"
          end
          return perfect_sqr_count

        elsif new_node.sum < n && !checked_sums.include?(new_node)
          next_nodes << new_node
          checked_sums.add(new_node)
        end
      end
    end
    perfect_sqr_count += 1
    nodes = next_nodes
  end
end

# Given a max value, will return an Array of perfect squares, smaller or equal to max.
# @param {Integer} max
# @return {Array<Integer>}
#
def get_squares(max)
  squares = Array.new
  next_root = 1

  loop do
    next_square = next_root ** 2
    break if (next_square > max)
    squares << next_square
    next_root += 1
  end
  squares
end

def test(list)
  list.each do |n|
    benchmark = Benchmark.realtime { num_squares(n) }
    puts "\t took #{benchmark * (10 ** 6)} microseconds."
    puts
  end
end

if $debug >= 2
  test([49, 12, 13, 7168])
end
