module Commands
  mattr_accessor :listeners
  self.listeners = {}

module_function

  class Command
    attr_accessor :type, :data
    def initialize(type, data)
      @type, @data = type, data
    end
  end

  def listen(regex, &block)
    self.listeners[regex] = block
  end

  def process(message)
    listeners.detect do |regex, block|
      regex.match(message){ |matches| return block.call *matches }
    end
    send :text, message
  end

  def send(type, data)
    Command.new type, data
  end

  # placeholder
  def command(type, data)
    Command.new type, data
  end
end