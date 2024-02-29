require_relative 'modules/company_manufacture'
require_relative 'modules/validation'

class Wagon

  include CompanyManufacture
  include Validation

  attr_reader :type

  def initialize
    @type = nil
  end

  private

  def validate!
    errors = []
    errors << "Вагон не может быть nil'" if @type.nil?
    errors << "Введен неправильный тип вагона" unless @type == :passenger or @type == :cargo
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end