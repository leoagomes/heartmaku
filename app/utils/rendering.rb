module Utils
  module Rendering
    class Circle
      attr_reader :radius, :render_target, :x, :y, :r, :g, :b, :a, :fill

      alias fill? fill

      def initialize(radius:, render_target:, x:, y:, r:, g:, b:, a:, fill:)
        @x = x.floor
        @y = y.floor
        @radius = radius.floor
        @fill = fill
        @render_target = render_target
        @r = r
        @g = g
        @b = b
        @a = a
      end

      def draw
        center_x = self.x
        center_y = self.y

        x = 0
        y = self.radius
        d = 3 - 2 * radius

        if fill?
          fill_octants(x, y)
        else
          draw_octants(x, y)
        end

        while y >= x
          x += 1

          if d > 0
            y -= 1
            d = d + 4 *  (x - y) + 10
          else
            d = d + 4 * x + 6
          end

          if fill?
            fill_octants(x, y)
          else
            draw_octants(x, y)
          end
        end
      end

      private

      def draw_octants(x, y)
        center_x = self.x
        center_y = self.y

        [
          [center_x + x, center_y + y],
          [center_x - x, center_y + y],
          [center_x + x, center_y - y],
          [center_x - x, center_y - y],
          [center_x + y, center_y + x],
          [center_x - y, center_y + x],
          [center_x + y, center_y - x],
          [center_x - y, center_y - x]
        ].each do |(x, y)|
          set_pixel!(x, y)
        end
      end

      def fill_octants(x, y)
        center_x = self.x
        center_y = self.y

        ((center_x - x)..(center_x + x)).each do |xx|
          set_pixel!(xx, center_y + y)
          set_pixel!(xx, center_y - y)
        end
        ((center_x - y)..(center_x + y)).each do |xx|
          set_pixel!(xx, center_y + x)
          set_pixel!(xx, center_y - x)
        end
      end

      def set_pixel!(x, y)
        render_target.solids << {
          x: x, y: y,
          w: 1, h: 1,
          r: r, g: g, b: b, a: a,
        }
      end
    end
  end
end
