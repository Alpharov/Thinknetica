class Train	

	include Company_name
	include InstanceCounter

	@@trains = []

	def self.find(car_number)
		@@trains.find { |train| train.car_number == car_number }
	end


	attr_reader :speed, :wagons, :route, :car_number

	def initialize(car_number)
		@car_number = car_number
		@wagons = []
		@speed = 0
		@@trains << self
	end

	def up_speed
		@speed += 10
		puts "скорость увеличена на 10"
	end

	def stop
		@speed = 0
	end

	def add_wagon(wagon)
		if @speed.zero?
			@wagons << wagon 
			puts "Добавлен один вагон. Всего вагонов: #{wagons.size}" 
		else
			puts "Вагон в движении, прицепить невозможно."
		end
	end

	def remove_wagon 
		if @speed.zero? && wagons.any?
			wagons.pop
			puts "Вагон отцеплен. Всего вагонов: #{wagons.size} "
		else
			puts "Вагон в движении, отцепить невозможно, или вагонов нет."
		end
	end

	def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def move_forward
    if next_station
    	current_station.departure_train(self)
      @current_station_index += 1
      current_station.add_train(self)
      puts "Перемещение вперед. Текущая станция: #{current_station.name}"
    else
      puts "Нельзя двигаться вперед, конечная станция."
    end
  end

  def move_backward
    if previous_station
    	current_station.departure_train(self)
      @current_station_index -= 1
      current_station.add_train(self)
      puts "Перемещение назад. Текущая станция: #{current_station.name}"
    else
      puts "Нельзя двигаться назад, начальная станция."
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end


end
