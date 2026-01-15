module Entities
  class Bullet < Base
    def initialize(x: 0, y: 0, w: 16, h: 16, vx: 0, vy: 0)
      with_color!(Constants::Colors[:white])
      with_sprite!(Constants::Sprites::OneBitPack[:circle])
      with_anchor_center!
      with_position!(x: x, y: y)
      with_dimensions!(w: w, h: h)
      with_velocity!(vx: vx, vy: vy)
    end

    def tick
      apply_velocity!
    end
  end
end
