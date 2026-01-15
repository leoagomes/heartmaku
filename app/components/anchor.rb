module Components
  module Anchor
    def self.included(klass)
      klass.attr_accessor :anchor_x, :anchor_y
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
