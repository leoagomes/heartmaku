module Colored
  def with_color!(color)
    @r = color.r
    @g = color.g
    @b = color.b
    @a = color.a
    self
  end
end
