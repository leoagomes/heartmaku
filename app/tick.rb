def tick(args)
  args.state.tools ||= {}
  args.state.tools.asset_viewer ||= Tools::AssetViewer.new
  args.state.game ||= Game.new

  args.state.active_scene ||= :game

  # scene activation toggles
  if args.inputs.keyboard.alt_a
    args.state.active_scene =
      if args.state.active_scene == :asset_viewer
        :game
      else
        :asset_viewer
      end
  end

  active_scene =
    if args.state.active_scene == :game
      args.state.game
    elsif args.state.active_scene == :asset_viewer
      args.state.tools.asset_viewer
    end

  active_scene.args = args
  active_scene.tick
end
