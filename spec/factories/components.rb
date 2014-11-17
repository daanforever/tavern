# == Schema Information
#
# Table name: components
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  disabled    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :component do
    name        { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
    disabled    false
    project     { create(:project) }
  end
end
