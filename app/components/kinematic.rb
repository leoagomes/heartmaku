module Components
  module Kinematic
    attr_accessor :vx, :vy,
                  :accel_x, :accel_y,
                  :speed

    def velocity
      return @vx, @vy
    end
    alias vel velocity

    def velocity=(velocity)
      @vx = velocity.x
      @vy = velocity.y
      velocity
    end
    alias vel= velocity=

    def acceleration
      return @accel_x, @accel_y
    end
    alias accel acceleration

    def acceleration=(acceleration)
      @accel_x = acceleration.x
      @accel_y = acceleration.y
      acceleration
    end
    alias accel= acceleration=

    def derive_velocity_from_speed_and_angle!
      vec = Geometry.angle_vec(@angle)
      @vx = vec.x * @speed
      @vy = vec.y * @speed
      return @vx, @vy
    end

    def apply_velocity!
      @x += @vx
      @y += @vy
      self
    end
  end
end
