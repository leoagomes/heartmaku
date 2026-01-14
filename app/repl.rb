xrepl do
  class Spawner < Enumerator
    def self.of(klass)
      new do |yielder|
        loop do
          yielder << klass.new(x: 0, y: 0)
        end
      end
    end

    def ring(angle:, center:, distance:, count:, speed:)
      return to_enum(:ring, angle: angle, center: center, distance: distance, count: count, speed: speed) unless block_given?

      arc = (Math::PI * 2) / count
      count.times do |index|
        current_angle = angle + arc * index
        direction = Vector.from_polar(current_angle, 1)
        spawn_point = Vector.multiply_scalar(direction, distance) + center
        velocity = Vector.multiply_scalar(direction, speed)

        bullet = self.next
        bullet.x = spawn_point.x
        bullet.y = spawn_point.y
        bullet.velocity = velocity

        yield bullet
      end
    end

    def stack(count:, speed:)
      return to_enum(:stack, count: count, speed: speed) unless block_given?

      count.times do |index|
      end
    end

    def to_enum(meth, *args)
      Spawner.new(self, meth, *args)
    end
  end

  bs = Spawner.of(Entities::Bullet)

  result =
    Spawner
      .of(Entities::Bullet)
      .ring(angle: 0, center: [0, 0], distance: 10, count: 3, speed: 10)

  puts result

  result.each do |bullet|
    puts bullet.inspect
  end
end
