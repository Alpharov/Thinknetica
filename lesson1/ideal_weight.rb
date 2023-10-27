puts "Узнаем ваш идеальный вес. Как вас зовут?"
name = gets.chomp.capitalize

puts "отлично, #{name}, какой у вас рост?"
height = gets.chomp.to_i

weight = (height - 110)*1.15

if weight>0
	print "Ваш вес #{weight}."
else
	print "Ваш вес является оптимальным."
end