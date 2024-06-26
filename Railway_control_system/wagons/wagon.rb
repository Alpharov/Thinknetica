# frozen_string_literal: true

class Wagon
  include CompanyManufacture
  include Validation

  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    total_place - used_place
  end

  def take_place
    raise 'Не реализовано!'
  end

  private

  def validate!
    errors = []
    errors << 'Тип вагона не может быть пустым' if @type.nil?
    errors << 'Введен неправильный тип вагона' unless (@type == :passenger) || (@type == :cargo)
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end
