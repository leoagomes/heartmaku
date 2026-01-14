module Entities
  class Bullet < Base
    include Kinematic

    attr_accessor :velocity

    def initialize(x:, y:, velocity: Vector.zero)
      with_color!(Constants::Colors[:white])
      with_sprite!(Constants::Sprites::OneBitPack[:circle])
      @x = 0
      @y = 0
      @w = 16
      @h = 16
      @velocity = velocity
      @anchor_x = 0.5
      @anchor_y = 0.5
    end

    def tick
      apply_velocity!
    end
  end
end
