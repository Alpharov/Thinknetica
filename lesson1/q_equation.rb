puts "Введите 3 коэффициента a,b,c:"
puts "a = "
a = gets.chomp.to_i

puts "b = "
b = gets.chomp.to_i

puts "c = "
c = gets.chomp.to_i

d = b**2 - 4*a*c 

if d>0
  puts "Дискриминант = #{d}"
  puts "Первый корень = #{(-b + Math.sqrt(d)) / (2*a)}"
  puts "Второй корень = #{(-b - Math.sqrt(d)) / (2*a)}"
elsif d == 0
  puts "Дискриминант = #{d}"
  puts "Корень = #{-b / (2*a)}"
else 
  puts "Дискриминант = #{d}. Корней нет."
end
