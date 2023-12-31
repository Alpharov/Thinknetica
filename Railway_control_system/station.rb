class Station

  include Instance_Counter

  @@all_stations = []

  def self.all
    @@all_stations
  end

  attr_reader :trains, :name
  
  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def departure_train(train)
    trains.delete(train)
  end
end
