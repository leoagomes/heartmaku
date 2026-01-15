module Components
  module Spatial
    attr_accessor :anchor_x, :anchor_y

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
