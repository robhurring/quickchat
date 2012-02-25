class Room
  include Mongoid::Document
  include Mongoid::Timestamps
  cache

  field :name, type: String
  field :topic, type: String
  field :private, type: Boolean
  field :password, type: String

  embeds_many :messages

  validates_presence_of :name
  validates_presence_of :password, :if => proc{ |r| r.private == true }

  def channel
    "presence-#{id}"
  end

  def as_json(options = {})
    super only: [:_id, :name, :topic, :messages]
  end
end