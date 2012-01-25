class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :username, type: String
  field :data, type: String

  embedded_in :room
end