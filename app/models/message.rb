class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :username, type: String
  field :data, type: String

  embedded_in :room

  def as_json(options = {})
    super only: [:id, :username, :data]
  end
end