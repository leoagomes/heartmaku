module Constants
  module Sprites
    module OneBitPack
      PATH = 'sprites/1-bit-pack.png'

      TILE_WIDTH = 16
      TILE_HEIGHT = 16

      SPRITES = {
        heart: [39, 10],
        circle: [39, 13],
      }.transform_values do |(x, y)|
        path = PATH
        w = TILE_WIDTH
        h = TILE_HEIGHT

        {
          tile_x: x * w, tile_y: y * h,
          tile_w: w, tile_h: h,
          path: path,
        }
      end

      def self.[](label)
        SPRITES[label]
      end
    end
  end
end
