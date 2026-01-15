module Components
  module Sprite
    def self.included(klass)
      klass.attr_sprite
    end

    def with_sprite!(sprite)
      @path = sprite.path
      @tile_x = sprite.tile_x
      @tile_y = sprite.tile_y
      @tile_w = sprite.tile_w
      @tile_h = sprite.tile_h
      self
    end
  end
end
