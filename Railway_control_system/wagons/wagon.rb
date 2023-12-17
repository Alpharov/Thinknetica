class Wagon

  include Company_name

  attr_reader :type

  def initialize
    @type = nil
  end
end