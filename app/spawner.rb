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
