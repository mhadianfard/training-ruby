def caesar_cipher(plain_text, shift_by)
  cipher = ''
  plain_text.each_char do |plain_char|
    if ('a'..'z') === plain_char
      cipher_char = shift(plain_char, 'a', shift_by)

    elsif ('A'..'Z') === plain_char
      cipher_char = shift(plain_char, 'A', shift_by)

    else
      cipher_char = plain_char
    end

    cipher << cipher_char
  end

  cipher
end

def shift(plain_char, starting_char, by)
  plain_byte = plain_char.ord
  offset = starting_char.ord
  (((plain_byte + by - offset) % 26) + offset).chr
end

puts caesar_cipher("What a string!", 5)
puts caesar_cipher("ABC abc", 1)
puts caesar_cipher("XYZ xyz", 1)
puts caesar_cipher("XYZ xyz", 0)