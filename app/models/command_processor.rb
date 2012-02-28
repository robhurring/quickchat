class CommandProcessor
  class_attribute :listeners, :actions
  self.listeners = {}
  self.actions = {}

  class << self
    def listen(regex, &block)
      self.listeners[regex] = block
    end

    def action(name, &block)
      self.actions[name] = block
    end

    def setup(&block)
      instance_eval &block
    end
  end

  class Sandbox
    attr_accessor :current_user, :message

    def initialize(current_user, message, actions)
      @current_user = current_user
      @message = message

      actions.each do |method, block|
        meta_def(method, &block)
      end
    end

    def pusher
      Pusher[message.room.channel]
    end

    def set_type(val)
      message.type = val
    end

    def set_data(val)
      message.data = val
    end

  private

    def meta_def(name, &block)
      (class << self; self; end).instance_eval { define_method name, &block }
    end
  end

  def initialize(context)
    @context = context
  end

  def process(message)
    sandbox = Sandbox.new(@context.current_user, message, self.actions)

    self.listeners.each do |regex, action|
      regex.match(message.data) do |matches|
        sandbox.instance_exec(message.data, *matches[1..-1], &action)
      end
    end

    sandbox.message
  end
end