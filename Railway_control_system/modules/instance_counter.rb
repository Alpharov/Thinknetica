module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def instances
      @instances ||= 0
    end

    def increase_instance_counter
      self.instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.increase_instance_counter
    end
  end
end
