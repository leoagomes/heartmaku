module Entities
  class Base
    include Argumentable
    include Spriteable
    include Colored

    attr_sprite
    attr_gtk
  end
end
