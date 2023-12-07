class PassengerTrain < Train 
	def initialize(car_number)
		super
		@type =	:passenger
	end

	def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def remove_wagon
    @wagons.pop
  end

  def route
    @route
  end


end
