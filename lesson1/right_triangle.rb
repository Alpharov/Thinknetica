puts "Введите известные стороны треугольника:"
print "a = "
a = gets.chomp.to_i

print "b = "
b = gets.chomp.to_i

print "c = "
c = gets.chomp.to_i

sides = [a,b,c].sort

if a == b && b == c && c == a 
	print "Треугольник является равносторонним"
elsif (a == b) || (b == c) || (c == a)
	print "Треугольник является равнобедренным"
elsif sides[0]**2 + sides[1]**2 == sides[2]**2
	print "Треугольник является прямоугольным"
else
	print "данные треугольника введены неверно."
end