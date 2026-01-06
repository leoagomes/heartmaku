module Entities
  class Player < Base
    def initialize(x: 0, y: 0)
      with_sprite!(Constants::Sprites::OneBitPack[:heart])
      with_color!(Constants::Colors[:red])
      @x = x
      @y = y
      @w = @h = 16
      @anchor_x = @anchor_y = 0.5
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
