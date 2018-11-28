#!/bin/ruby

require 'json'
require 'stringio'



#
# Complete the 'twins' function below.
#
# The function is expected to return a STRING_ARRAY.
# The function accepts following parameters:
#  1. STRING_ARRAY a
#  2. STRING_ARRAY b
#

def twins(a, b)
  results = []
  a.size.times do |i|
    results[i] = is_twin?(a[i], b[i]) ? "Yes" : "No"
  end
  results
end

def is_twin?(string1, string2)
  return false if string1.size != string2.size

  hash1 = split_to_odd_and_even(string1)
  hash2 = split_to_odd_and_even(string2)

  (hash1[:evens] == hash2[:evens]) && (hash1[:odds] == hash2[:odds])
end

def split_to_odd_and_even(string)
  evens = []
  odds = []
  string.size.times do |i|
    if i % 2 == 0
      evens << string[i]
    else
      odds << string[i]
    end
  end
  {:evens => evens.sort, :odds => odds.sort}
end

a = ["cdab", "dcba", "abcd"]
b = ["abcd", "abcd", "abcdcd"]
puts twins(a, b).inspect

#puts split_to_odd_and_even("acdgfe").inspect
#
# puts is_twin?("dcba", "abcd").inspect