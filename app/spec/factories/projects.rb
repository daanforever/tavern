# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  visible     :boolean
#  disabled    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    label       { Faker::Lorem.word }
    visible     true
    disabled    false
  end
end
