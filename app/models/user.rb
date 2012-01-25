class User
  attr_accessor :name

  def self.anonymous
    new 'anonymous'
  end

  def initialize(name)
    @name = name
  end
end