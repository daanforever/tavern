# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  url            :string(255)
#  disabled       :boolean
#  info           :text
#  created_at     :datetime
#  updated_at     :datetime
#  environment_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    name            { Faker::Lorem.word }
    description     { Faker::Lorem.sentence }
    url             { Faker::Internet.url }
    disabled        false
    environment_id  { create(:environment).id }
  end
end
