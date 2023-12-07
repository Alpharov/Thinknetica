class CargoTrain < Train 
	def initialize(car_number)
		super
		@type = :cargo 
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