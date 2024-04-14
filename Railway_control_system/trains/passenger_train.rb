# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :type

  def initialize(car_number)
    super
    @type =	:passenger
  end
end
