class Spawner < Enumerator
  def self.of(klass)
    new do |yielder|
      loop do
        yielder << klass.new(x: 0, y: 0)
      end
    end
  end

  def self.single(klass)
    new { |y| y << klass.new(x: 0, y: 0) }
  end

  def with_velocity!(velocity)
    return to_enum(:with_velocity!, velocity) unless block_given?

    each do |bullet|
      bullet.velocity = velocity
      yield bullet
    end
  end

  def ring(angle:, center:, distance:, count:, speed:)
    return to_enum(:ring, angle: angle, center: center, distance: distance, count: count, speed: speed) unless block_given?

    arc = (Math::PI * 2) / count
    each do |og_bullet|
      count.times do |index|
        current_angle = angle + arc * index
        direction = Vector.from_polar(current_angle, 1)
        spawn_point = Vector.multiply_scalar(direction, distance) + center
        velocity = Vector.multiply_scalar(direction, speed)

        bullet = og_bullet.dup
        bullet.x += spawn_point.x
        bullet.y += spawn_point.y
        bullet.velocity = velocity.add!(bullet.velocity)

        yield bullet
      end
    end
  end

  def stack(count:, min_speed:, max_speed:)
    return to_enum(:stack, count: count, min_speed: min_speed, max_speed: max_speed) unless block_given?

    each do |og_bullet|

      # puts(bullet, og_bullet)

      speed_increment = (max_speed - min_speed) / count
      count.times do |index|
        bullet = og_bullet.dup
        speed = min_speed + (index * speed_increment)
        # puts "loop"
        # puts bullet.velocity
        bullet.velocity = Vector.multiply_scalar(og_bullet.velocity, speed)
        # puts bullet.velocity

        # puts("iter: #{index}")

        yield bullet
      end
    end

  end

  def to_enum(meth, *args)
    Spawner.new(self, meth, *args)
  end
end

class World
  WIDTH = 1800
  HEIGHT = 1800

  SPATIAL_SPACING = 32
  SPATIAL_MAX_ENTRIES = 1_000

  include Components::Arguments

  attr_gtk
  attr_accessor :entities, :spatial, :camera, :player

  def initialize
    @spatial = Spatial::Hash.new(spacing: SPATIAL_SPACING, max_entries: SPATIAL_MAX_ENTRIES)
    @player = Entities::Player.new(x: 0, y: 0)
    @entities = []

    @fire_ticks = 0
    @fire_angle = 0

    # setup code
    @entities << @player

    Grid.origin_center!
  end

  def tick
    update
    draw
  end

  def update
    should_shoot = true
    # should_shoot = args.inputs.keyboard.key_down?(:space)
    if should_shoot && @fire_ticks <= 0
      # fire_ring!(
        # kind: Entities::Bullet,
      #   angle: @fire_angle,
      #   center: [-100, 0],
      #   distance: 32,
      #   count: 50,
      #   speed: 2,
      # )
      # fire_ring!(
      #   kind: Entities::Bullet,
      #   angle: @fire_angle,
      #   center: [100, 0],
      #   distance: 20,
      #   count: 50,
      #   speed: 1,
      # )
      Spawner
        .single(Entities::Bullet)
        .with_velocity!([0, 0])
        # .stack(count: 3, min_speed: 1, max_speed: 2)
        .ring(
          angle: @fire_angle,
          center: [100, 0],
          distance: 50,
          count: 50,
          speed: 0.5,
        )
        # .stack(count: 3, min_speed: 1, max_speed: 2)
        .ring(
          angle: 0,
          center: [0, 0],
          distance: 0,
          count: 9,
          speed: 1,
        )
        .stack(count: 3, min_speed: 1, max_speed: 2)
        .each(&method(:register!))
      @fire_ticks = 300
      @fire_angle += Math::PI / 10
    end
    @fire_ticks -= 1

    viewport_rect = { x: -640, y: -360, w: 1280, h: 720 }

    # to_delete = []
    # entities.each do |entity|
    #   entity
    #     .with_args!(args)
    #     .tick
    #   unless Geometry.inside_rect?(entity, viewport_rect)
    #     to_delete << entity
    #   end
    # end

    # to_delete.each do |entity|
    #   entities.delete(entity)
    #   args.outputs.static_sprites.delete(entity)
    # end

    args.outputs.static_primitives.filter! do |entity|
      next true unless entity.is_a?(Entities::Base)
      entity
        .with_args!(args)
        .tick
      Geometry.inside_rect?(entity, viewport_rect)
    end

    # spatial.populate(entities)
  end

  def fire_ring!(kind:, angle:, center:, distance:, count:, speed:)
    arc = (Math::PI * 2) / count
    count.each do |index|
      current_angle = angle + arc * index
      direction = Vector.from_polar(current_angle, 1)
      spawn_point = Vector.multiply_scalar(direction, distance) + center
      velocity = Vector.multiply_scalar(direction, speed)

      bullet = kind.new(
        x: spawn_point.x,
        y: spawn_point.y,
        velocity: velocity
      )

      # @entities << bullet
      register!(bullet)
    end
  end

  def register!(bullet)
    args.outputs.static_primitives << bullet
  end

  def draw
    background_color = Constants::Colors[:black]
    args.outputs.background_color = background_color

    # entities.each do |entity|
    #   args.outputs.primitives << entity
    # end

    args.outputs.debug << args.gtk.framerate_diagnostics_primitives
    args.outputs.debug << "Entities: \##{@entities.count}"
    args.outputs.debug << "Static Primitives: \##{args.outputs.static_primitives.count}"
  end
end
