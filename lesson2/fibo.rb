fn = [0,1]

while fn.last <= 100
	new_number = fn[-2] + fn[-1]
	break if new_number >= 100

	fn<<new_number

end

puts fn 
