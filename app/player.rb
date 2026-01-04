class Player
  include Constants::Sprites
  include Constants::Colors

  attr_sprite
  attr_gtk

  def initialize(x: 0, y: 0)
    load_sprite_data!(Constants::Sprites::OneBitPack[:heart])
    load_color_data!(Constants::Colors[:red])
    @x = x
    @y = y
    @w = 16
    @h = 16
    @anchor_x = 0.5
    @anchor_y = 0.5
  end
end

