module Utils
  module Centerable
    def center_x
      x + half_w
    end

    def center_y
      y + half_h
    end

    def center_x=(value)
      self.x = value - half_w
    end

    def center_y=(value)
      self.y = value - half_h
    end

    def half_w
      self.w / 2
    end

    def half_h
      self.h / 2
    end

    def center
      [center_x, center_y]
    end

    def center=(value)
      self.center_x = value.x
      self.center_y = value.y
      value
    end
  end
end
