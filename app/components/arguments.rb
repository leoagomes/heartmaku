module Components
  module Arguments
    attr_gtk

    def with_args!(args)
      @args = args
      self
    end
  end
end
