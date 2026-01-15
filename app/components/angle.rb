module Components
  module Angle
    attr_accessor :angle

    def angle_radians
      @angle.to_radians
    end
    alias angle_rad angle_radians

    def angle_degrees
      @angle
    end
    alias angle_deg angle_degrees

    def with_angle!(angle)
      @angle = angle
      self
    end

    def with_angle_rad!(angle)
      with_angle!(angle.to_degrees)
    end
  end
end
