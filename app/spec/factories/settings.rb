# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :settings, :class => 'Settings' do
    key   { Faker::Lorem.word }
    value { Faker::Lorem.sentence }
  end
end
