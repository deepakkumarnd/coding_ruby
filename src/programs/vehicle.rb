module Vehicle
  class Base
    attr_reader :maker

    def initialize(maker) = @maker = maker  
  end

  module Electric
    def fuel_type
      'electric'
    end
  end

  module ICE
    def fuel_type
      'petrol/diesel/gas'
    end
  end

  module TwoWheeler
    def no_wheels
      2
    end
  end

  module ThreeWheeler
    def no_wheels
      3
    end
  end

  module FourWheeler
    def no_wheels
      4
    end
  end

  class Car
    include FourWheeler
    include Electric
  end

  class MotorBike < Base
    include TwoWheeler
    include ICE

    def initialize(maker) = super(maker)
  end

  class AutoRikshaw < Base
    include ThreeWheeler
    include Electric
    
    def initialize(maker) = super(maker)
  end
end

my_bike = Vehicle::MotorBike.new('Royal Enfield')

p my_bike.maker
p my_bike.fuel_type
p my_bike.no_wheels