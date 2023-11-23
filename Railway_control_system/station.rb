class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_trains
    @trains
  end

  def type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def departure_train(train)
    @trains.delete(train)
  end
end
