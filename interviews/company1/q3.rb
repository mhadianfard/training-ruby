def getMinimumUniqueSum(arr)

  loop do
    found_duplicates = false
    arr.each_with_index do |element, index|
      is_duplicate = arr.count(element) > 1
      if is_duplicate
        arr[index] += 1
        found_duplicates = true
        break
      end
    end

    break unless found_duplicates
  end

  return arr.reduce(:+)
end

puts getMinimumUniqueSum([3, 1, 2, 3])
