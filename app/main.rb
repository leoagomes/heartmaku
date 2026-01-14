require 'lib/frame/vector.rb'
require 'lib/frame/spatial.rb'

require 'app/concerns/argumentable.rb'
require 'app/concerns/colored.rb'
require 'app/concerns/spriteable.rb'
require 'app/concerns/kinematic.rb'

require 'app/constants/colors.rb'
require 'app/constants/sprites.rb'

# TODO: reconsider
require 'app/utils/centerable.rb'

# Dev tools
require 'app/tools/asset_viewer.rb'

# Entities
require 'app/entities/base.rb'
require 'app/entities/player.rb'
require 'app/entities/enemy.rb'
require 'app/entities/bullet.rb'

require 'app/camera.rb'
require 'app/game.rb'
require 'app/world.rb'

require 'app/tick.rb'
