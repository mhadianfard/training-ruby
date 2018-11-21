
# while gets
#   print if /start/../end/
# end

A = [1, 2, 3, 4, 5, 6]
B = [4, 5, 6, 7, 8, 9]

C = A & B
D = B - A
E = B + A
F = E.sort

puts "C = #{C.inspect}"
puts "D = #{D.inspect}"
puts "E = #{E.inspect}"
puts "F = #{F.inspect}"

A.pop
puts "A = #{A.inspect}"

A.shift
puts "A = #{A.inspect}"

A << 111
puts "A = #{A.inspect}"

G = A.clone
G.push(222, 333, 444, 555)
puts "G = #{G.inspect}"

H = A.clone
H.push(*[222, 333, 444, 555])
puts "H = #{H.inspect}"

H.delete(222)
puts "H = #{H.inspect}"