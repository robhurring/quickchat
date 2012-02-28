class User
  include Mongoid::Document

  field :name, type: String
  field :last_message, type: DateTime

  has_and_belongs_to_many :rooms

  def self.anonymous
    create name: 'anonymous'
  end

  def heartbeat!
    update_attribute :last_message, Time.now
  end

  def as_json(options = {})
    super only: [:_id, :name]
  end
end