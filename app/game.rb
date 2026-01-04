class Game
  WORLD_WIDTH = 1800
  WORLD_HEIGHT = 1800

  attr_gtk
  attr_reader :player, :camera

  def initialize
    @camera = Camera.new(x: 0, y: 0, world_w: WORLD_WIDTH, world_h: WORLD_HEIGHT)
    @player = Player.new(x: 100, y: 100)
    @camera.center = [@player.x, @player.y]
    @bullets = []
    @spatial = Spatial::Hash
  end

  def tick
    defaults
    update
    draw
  end

  def defaults
  end

  def update
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

