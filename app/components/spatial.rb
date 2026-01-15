module Components
  module Spatial
    def self.included(klass)
      klass.attr_accessor :x, :y,
                          :w, :h
    end

    def position
      return @x, @y
    end
    alias pos position

    def position=(position)
      @x = position.x
      @y = position.y
      position
    end
    alias pos= position=

    def with_position!(x: nil, y: nil)
      @x = x unless x.nil?
      @y = y unless y.nil?
      self
    end

    def dimensions
      return @w, @h, @w, @h
    end
    alias dims dimensions

    def dimensions=(dimensions)
      @w = dimensions.w
      @h = dimensions.h
      dimensions
    end
    alias dims= dimensions=

    def with_dimensions!(w: nil, h: nil)
      @w = w unless w.nil?
      @h = h unless h.nil?
      self
    end

    def bounds
      return @x, @y, @w, @h
    end

    def bounds=(bounds)
      @x = bounds.x
      @y = bounds.y
      @w = bounds.w
      @h = bounds.h
      bounds
    end
  end
end
