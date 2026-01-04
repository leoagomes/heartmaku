class Camera
  include Utils::Centerable

  TARGET_NAME = :scene

  VIEWPORT_WIDTH = 1280
  VIEWPORT_HEIGHT = 720
  DEFAULT_SCALE = 2

  attr_gtk
  attr_accessor :x, :y, :scale, :world_w, :world_h

  def initialize(x: 0, y: 0, world_w:, world_h:, scale: DEFAULT_SCALE)
    @x = x
    @y = y
    @world_w = world_w
    @world_h = world_h
    @scale = scale
  end

  def to_world(screen_xy)
    screen_x = screen_xy.x
    screen_y = screen_xy.y

    world_x = (screen_x / scale) + x
    world_y = (screen_y / scale) + y

    [world_x, world_y]
  end

  def to_screen(world_xy)
    world_x = world_xy.x
    world_y = world_xy.y

    screen_x = (world_x - x) * scale
    screen_y = (world_y - y) * scale

    [screen_x, screen_y]
  end

  def world_aabb
    [x, y, w, h]
  end

  def w
    viewport_w / scale
  end

  def h
    viewport_h / scale
  end

  def viewport_aabb
    [viewport_x, viewport_y, viewport_w, viewport_h]
  end

  def viewport_w
    VIEWPORT_WIDTH
  end

  def viewport_h
    VIEWPORT_HEIGHT
  end

  def render
    target = args.outputs[TARGET_NAME]

    target.w = world_w
    target.h = world_h

    yield(target) if block_given?

    args.outputs.sprites << {
      x: -x * scale, y: -y * scale,
      w: world_w * scale, h: world_h * scale,
      path: TARGET_NAME,
    }
  end
end
