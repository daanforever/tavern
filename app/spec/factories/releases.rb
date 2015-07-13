# == Schema Information
#
# Table name: releases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#  state       :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end

  factory :release_with_project, parent: :release do
    project
  end
end
