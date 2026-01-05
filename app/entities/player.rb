module Entities
  class Player
    include Spriteable
    include Colored

    attr_sprite
    attr_gtk

    def initialize(x: 0, y: 0)
      with_sprite!(Constants::Sprites::OneBitPack[:heart])
      with_color!(Constants::Colors[:red])
      @x = x
      @y = y
      @w = 16
      @h = 16
      @anchor_x = 0.5
      @anchor_y = 0.5
    end

    def tick
      move!
    end

    def move!
      x = args.inputs.left_right
      y = args.inputs.up_down

      self.x += x
      self.y += y
    end
  end
end
