class Route

	include Instance_Counter
	
	attr_reader :stations

	def initialize(start_station, end_station)
		@stations = [start_station, end_station]
	end

	def add_station(station)
		stations.insert(-1, station)
	end

	def delete_station(station)
		stations.delete(station)
	end

	def show_stations 
		stations.each { |station| puts station }
	end
end