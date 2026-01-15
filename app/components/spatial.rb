module Components
  module Spatial
    attr_accessor :x, :y,
                  :w, :h,
                  :angle,
                  :anchor_x, :anchor_y

    def with_position!(x: nil, y: nil)
      @x = x unless x.nil?
      @y = y unless y.nil?
      self
    end

    def with_dimensions!(w: nil, h: nil)
      @w = w unless w.nil?
      @h = h unless h.nil?
      self
    end

    def with_angle!(angle)
      @angle = angle
      self
    end

    def with_anchor!(x: nil, y: nil)
      @anchor_x = x unless x.nil?
      @anchor_y = y unless y.nil?
      self
    end

    def with_anchor_center!
      @anchor_x = @anchor_y = 0.5
      self
    end
  end
end
