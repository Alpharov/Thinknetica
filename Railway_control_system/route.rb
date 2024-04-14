# frozen_string_literal: true

class Route
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

  private

  def validate!
    raise 'Необходимо создать начальную и конечную станции' if @stations.size < 2
  end
end
