module Entities
  class Bullet < Base
    attr_accessor :velocity

    def initialize(velocity: Vector.zero)
      @velocity = velocity
      @anchor_x = 0.5
      @anchor_y = 0.5
    end
  end
end
