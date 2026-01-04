module Tools
  class AssetViewer
    MIN_ZOOM = 0.5
    GRID_COLOR = Constants::Colors[:light_gray]
    ASSETS = {
      one_bit_pack: {
        w: 784,
        h: 352,
        tile_w: 16,
        tile_h: 16,
        tiles_x: 784 / 16,
        tiles_y: 352 / 16,
        path: 'sprites/1-bit-pack.png',
      },
    }

    attr_gtk
    attr_reader :asset_name, :pan, :zoom, :zoom_sens

    def initialize
      @asset_name = nil
      @pan = Vector.zero
      @zoom = 1.0
      @asset_name = ASSETS.keys.first
      @zoom_sens = 0.1
    end

    def tick
      process_input!
      draw!
    end

    def process_input!
      process_input_pan!
      process_input_wheel_zoom!
      process_input_key_zoom!
      process_input_reset!
    end

    def process_input_pan!
      mouse = args.inputs.mouse
      return unless mouse.button_middle

      pan.x -= mouse.relative_x
      pan.y -= mouse.relative_y
    end

    def process_input_wheel_zoom!
      wheel = args.inputs.mouse.wheel
      return unless wheel

      self.zoom += zoom_sens * wheel.y
    end

    def process_input_key_zoom!
      keyboard = args.inputs.keyboard

      self.zoom = 1.0 if keyboard.ctrl_zero || keyboard.ctrl_one
      self.zoom += zoom_sens if keyboard.ctrl_plus
      self.zoom -= zoom_sens if keyboard.ctrl_minus
      self.zoom = 2.0 if keyboard.ctrl_two
    end

    def process_input_reset!
      return unless args.inputs.keyboard.key_down.r

      center_x = asset.w / 2
      center_y = asset.h / 2
      @pan = [-center_x, -center_y]
      @zoom = 1.0
    end

    def draw!
      args.outputs.background_color = Constants::Colors[:black]
      draw_asset!
      draw_grid!
      draw_ui!
    end

    def asset
      ASSETS[asset_name]
    end

    def draw_asset!
      args.outputs.sprites << {
        x: -pan.x, y: -pan.y,
        w: asset.w * zoom, h: asset.h * zoom,
        r: 0xFF, g: 0xFF, b: 0xFF, a: 0xFF,
        path: asset.path,
      }
    end

    def draw_grid!
      # border
      args.outputs.primitives << {
        x: -pan.x, y: -pan.y,
        w: asset.w * zoom, h: asset.h * zoom,
        primitive_marker: :border,
      }.merge(GRID_COLOR)

      # vertical lines
      (asset.tiles_x - 1).each do |i|
        tile_w = asset.tile_w * zoom
        h = asset.h * zoom

        x = -pan.x + tile_w * (i + 1)
        y = -pan.y
        x2 = x
        y2 = -pan.y + h

        args.outputs.primitives << {
          x: x, y: y,
          x2: x2, y2: y2,
        }.merge(GRID_COLOR)
      end

      # horizontal lines
      (asset.tiles_y - 1).each do |i|
        tile_h = asset.tile_h * zoom
        w = asset.w * zoom

        x = -pan.x
        y = -pan.y + tile_h * (i + 1)
        x2 = -pan.x + w
        y2 = y

        args.outputs.primitives << {
          x: x, y: y,
          x2: x2, y2: y2,
        }.merge(GRID_COLOR)
      end
    end

    def draw_ui!
      draw_ui_top_bar!
      draw_ui_bottom_bar!
    end

    def draw_ui_top_bar!
    end

    def draw_ui_bottom_bar!
      tile = mouse_tile

      status_line = "zoom: #{zoom} cursor: [#{tile.asset_x}, #{tile.asset_y}] tile: i[#{tile.tile_x}, #{tile.tile_y}], px[#{tile.tile_x_pixels}, #{tile.tile_y_pixels}] source: i[#{tile.source_x}, #{tile.source_y}], px[#{tile.source_x_pixels}, #{tile.source_y_pixels}]"
      sl_w, sl_h = $gtk.calcstringbox(status_line)

      # background
      args.outputs.primitives << {
        x: 0, y: 0,
        w: 1280, h: sl_h + 16,
        primitive_marker: :solid,
      }.merge(Constants::Colors[:black]).merge(a: 225)
      args.outputs.primitives << {
        x: 8, y: 8 + sl_h,
        text: status_line,
      }.merge(Constants::Colors[:white])
    end

    def zoom=(value)
      value = MIN_ZOOM if value < MIN_ZOOM
      @zoom = value
    end

    def mouse_tile
      mouse = args.inputs.mouse
      asset_x = ((mouse.x + pan.x) / zoom).to_i
      asset_y = ((mouse.y + pan.y) / zoom).to_i
      asset_w = asset.w
      asset_h = asset.h
      tile_w = asset.tile_w
      tile_h = asset.tile_h
      source_x = (asset_x / tile_w).to_i
      source_y = (asset_y / tile_h).to_i
      source_x_pixels = source_x * tile_w
      source_y_pixels = source_y * tile_w
      tile_x = source_x
      tile_y = ((asset_h - asset_y) / tile_h).to_i
      tile_x_pixels = source_x_pixels
      tile_y_pixels = tile_y * tile_h

      {
        mouse_x: mouse.x,
        mouse_y: mouse.y,
        asset_x: asset_x,
        asset_y: asset_y,
        asset_w: asset_w,
        asset_h: asset_h,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_x_pixels: tile_x_pixels,
        tile_y_pixels: tile_y_pixels,
        tile_w: tile_w,
        tile_h: tile_h,
        source_x: source_x,
        source_y: source_y,
        source_x_pixels: source_x_pixels,
        source_y_pixels: source_y_pixels,
      }
    end
  end
end
