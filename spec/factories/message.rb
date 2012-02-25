FactoryGirl.define do
  factory :message do
    type :text
    data 'Hello World'
    username 'anonymous'
  end
end
