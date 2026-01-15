# Entities are often copied, and many are spawned and thrown away.
# For this reason, entities should be kept as small and flat as possible.
# This way, `dup` will return a full clone.
#
# If, for some reason, an entitie uses mutable nested objects, it should override
# `dup` to also clone that -- some sort of "deep" dup.
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
