# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type

  def initialize(car_number)
    super
    @type = :cargo
  end
end
