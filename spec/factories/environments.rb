# == Schema Information
#
# Table name: environments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  release_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :environment do
    name "MyString"
    project nil
    release nil
  end
end
