def substrings(sentence, dictionary)
  results = {}
  sentence.downcase!
  dictionary.each do |word|
    if sentence.include? word
      results[word] = sentence.scan(word).code_size
    end
  end
  results
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary).inspect
puts substrings("Howdy partner, sit down! How's it going?", dictionary).inspect