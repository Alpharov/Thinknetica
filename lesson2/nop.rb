purchase = {}
total_cost = 0 

loop do 
  puts "Введите название товара. Напишите 'стоп', если весь товар уже написан."
  name = gets.chomp
  break if name == "стоп"

  puts "Введите цену за товар:"
  price1 = gets.chomp.to_f

  puts "Какое количество данного товара куплено:"
  quantity1 = gets.chomp.to_f

  purchase[ name ] = { price: price1, quantity: quantity1 }
end

puts "Список покупок:"
purchase.each do |product, details|
  cost = details[:price] * details[:quantity]
  total_cost += cost
  puts "#{ product }: Цена за единицу - #{ details[:price] }, Количество - #{ details[:quantity] }, Сумма - #{ cost }"
end

puts "сумма всех покупок в корзине: #{ total_cost }"
