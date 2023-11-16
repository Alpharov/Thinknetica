puts "Введите дату:"
date = gets.chomp.to_i

puts "Введите месяц:"
months = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

february_day = leap_year ? 1 : 0

days_in_month = [31, 28 + february_day, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

ordinal_day = date
(1..(months - 1)).each { |m| ordinal_day += days_in_month[m - 1] }

puts "номер даты: #{ordinal_day}"