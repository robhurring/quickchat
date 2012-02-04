class Settings
  include Settable

  def initialize(&block)
    instance_eval(&block) if block_given?
  end
end