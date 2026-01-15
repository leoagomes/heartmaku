module Entities
  class Base
    include Components::Anchor
    include Components::Angle
    include Components::Arguments
    include Components::Color
    include Components::Kinematic
    include Components::Spatial
    include Components::Sprite
  end
end
