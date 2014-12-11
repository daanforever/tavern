FactoryGirl.define do
  factory :setting, :class => 'Settings' do
    key   { Faker::Lorem.word }
    value { Faker::Lorem.sentence }
  end
end
