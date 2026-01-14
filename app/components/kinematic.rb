module Components
  module Kinematic
    def apply_velocity!
      @x += @velocity.x
      @y += @velocity.y
      self
    end
  end
end
