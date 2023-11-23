class Train
	attr_accessor :speed

	def initialize(car_number, type, number_of_wagons)
		@car_number = car_number
		@type = type
		@number_of_wagons = number_of_wagons
		@speed = 0
		@route = nil
		@current_station_index = 0 
	end

	def up_speed
		@speed += 10
		puts "скорость увеличена на 10"
	end

	def stop
		@speed = 0
	end

	def attach_wagon
		if @speed.zero?
			@number_of_wagons += 1 
			puts "Добавлен один вагон. Всего вагонов: #{@number_of_wagons}" 
		else
			puts "Вагон в движении, прицепить невозможно."
		end
	end

	def detach_wagon 
		if @speed.zero?
			@number_of_wagons -= 1
			puts "Вагон отцеплен. Всего вагонов: #{@number_of_wagons} "
		else
			puts "Вагон в движении, отцепить невозможно."
		end
	end

	def set_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
    if @route && @current_station_index < @route.stations.size - 1
      @current_station_index += 1
      puts "Перемещение вперед. Текущая станция: #{current_station.name}"
    else
      puts "Нельзя двигаться вперед, конечная станция."
    end
  end

  def move_backward
    if @route && @current_station_index > 0
      @current_station_index -= 1
      puts "Перемещение назад. Текущая станция: #{current_station.name}"
    else
      puts "Нельзя двигаться назад, начальная станция."
    end
  end

  def current_station
    @route.stations[@current_station_index] if @route
  end

  def next_station
    @route.stations[@current_station_index + 1] if @route && @current_station_index < @route.stations.size - 1
  end

  def prev_station
    @route.stations[@current_station_index - 1] if @route && @current_station_index > 0
  end


end
