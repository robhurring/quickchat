module Commands
  mattr_accessor :listeners, :replacements
  self.listeners = {}
  self.replacements = {}

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

  def replace(regex, &block)
    self.replacements[regex] = block
  end

  def process(message)
    replacements.each do |regex, block|
      message.gsub!(regex, &block)
    end

    listeners.detect do |regex, block|
      regex.match(message){ |matches| return block.call message, *matches[1..-1] }
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