def tick(args)
  args.state.game ||= Game.new
  game = args.state.game

  game.args = args
  game.tick
end
