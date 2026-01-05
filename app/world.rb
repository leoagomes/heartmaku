class World
  WIDTH = 1800
  HEIGHT = 1800

  attr_accessor :entities, :spatial

  def initialize
    @camera = Camera.new(world_w: WIDTH, world_h: HEIGHT)
    @spatial = Spatial::Hash
    @entities = []
  end

  def tick
    update
    draw
  end

  def update
    entities.each do |entity|
      entity.args = args
      entity.tick
    end
  end

  def draw
    background_color = Constants::Colors[:black]
    args.outputs.background_color = background_color

    camera.args = args
    camera.render do |target|
      target.background_color = background_color
      target.primitives << player
    end
  end
end
