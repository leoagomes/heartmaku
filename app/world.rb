class World
  WIDTH = 1800
  HEIGHT = 1800

  SPATIAL_SPACING = 32
  SPATIAL_MAX_ENTRIES = 1_000

  include Argumentable

  attr_gtk
  attr_accessor :entities, :spatial, :camera, :player

  def initialize
    @camera = Camera.new(world_w: WIDTH, world_h: HEIGHT)
    @spatial = Spatial::Hash.new(spacing: SPATIAL_SPACING, max_entries: SPATIAL_MAX_ENTRIES)
    @player = Entities::Player.new(x: 100, y: 100)
    @entities = []

    # setup code
    @entities << @player
    @camera.center = Vector.from(player)
  end

  def tick
    update
    draw
  end

  def update
    entities.each do |entity|
      entity
        .with_args!(args)
        .tick
    end
    spatial.populate(entities)
  end

  def draw
    background_color = Constants::Colors[:black]
    args.outputs.background_color = background_color

    camera
      .with_args!(args)
      .render do |target|
        target.background_color = background_color

        spatial.query(camera.world_aabb) do |entity|
          target.primitives << entity
        end
      end

    args.outputs.debug << args.gtk.framerate_diagnostics_primitives
  end
end
