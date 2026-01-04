class Player
  attr_gtk
  attr_reader :x, :y, :w, :h

  def initialize(x:, y:, w: 10,h: 10)
    @w = w
    @h = h
    @x = x
    @y = y
  end

  def update
    move
  end

  def draw
  end

  private

  def move
  end
end

class Game
  attr_gtk

  attr_reader :player

  def initialize
    @player = Player.new(x: 100, y: 100)
    @bullets = []
    @spatial = Spatial::Hash
  end

  def tick
    defaults
    update
    draw
  end

  def defaults
    if !@filled_circle_render_target

      @filled_circle_render_target = true
    end
  end

  def filled_circle
    @filled_circle ||=
      begin
        filled_circle = :filled_circle
        render_target = args.outputs[filled_circle]

        Utils::Rendering::Circle.new(
          x: 0,
          y: 0,
          radius: 32,
          render_target: render_target,
          fill: true,
          r: 255, g: 255, b: 255, a: 255,
        ).draw

        filled_circle
      end
  end

  def circle_outline
    @circle_outline ||=
      begin
        circle_outline = :circle_outline
        render_target = args.outputs[circle_outline]

        Utils::Rendering::Circle.new(
          x: 0,
          y: 0,
          radius: 32,
          render_target: render_target,
          fill: false,
          r: 255, g: 255, b: 255, a: 255,
        ).draw

        circle_outline
      end
  end

  def update
    player.args = args
    player.update
  end

  def draw
    player.draw
  end
end

def tick(args)
  args.state.game ||= Game.new

  args.state.player ||= {}

  game = args.state.game

  game.args = args
  game.tick
end
