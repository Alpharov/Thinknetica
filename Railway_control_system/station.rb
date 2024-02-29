require_relative 'instance_counter'
require_relative 'validation'

class Station

  include InstanceCounter
  include Validation

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

  private

  def validate!
    errors = []
    errors << "Название станции не должно быть nil" if @name.nil?
    errors << "Введите название станции (название не может быть пустым)" if @name.empty?
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end
