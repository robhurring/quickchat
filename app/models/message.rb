class Message
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :username, type: String
  field :data, type: String
  field :type, type: Symbol

  embedded_in :room

  def data=(val)
    write_attribute :data, ERB::Util.html_escape(val)
  end

  def type
    super || :text
  end

  def as_json(options = {})
    super only: [:_id, :username, :data, :type]
  end
end