module Kinematic
  def move!
    self.x += self.velocity.x
    self.y += self.velocity.y
  end
end
