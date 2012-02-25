class Message
  Types = [:text, :sound, :image, :video, :command]

  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :username, type: String
  field :data, type: String
  field :type, type: Symbol

  embedded_in :room

  def type
    super || :text
  end

  def as_json(options = {})
    super only: [:id, :username, :data, :type]
  end
end