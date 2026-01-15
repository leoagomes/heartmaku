module Entities
  class Player < Base
    def initialize(x: 0, y: 0)
      with_sprite!(Constants::Sprites::OneBitPack[:heart])
      with_color!(Constants::Colors[:red])
      with_anchor_center!
      @x = x
      @y = y
      @w = @h = 16
    end

    def tick
      move!
    end

    def move!
      x = args.inputs.left_right
      y = args.inputs.up_down

      @x += x
      @y += y
    end
  end
end
