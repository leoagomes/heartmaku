module Components
  module Arguments
    def self.included(klass)
      klass.attr_accessor :args
    end

    def with_args!(args)
      @args = args
      self
    end
  end
end
