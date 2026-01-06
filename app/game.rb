class Game
  attr_gtk
  attr_reader :world

  def initialize
    @world = World.new
  end

  def tick
    world
      .with_args!(args)
      .tick
  end
end

