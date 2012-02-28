class User
  include Mongoid::Document

  field :username, type: String
  has_and_belongs_to_many :rooms

  def self.anonymous
    create name: 'anonymous'
  end
end