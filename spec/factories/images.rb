# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  disabled     :boolean
#  registry_id  :integer
#  project_id   :integer
#  release_id   :integer
#  component_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    name        { Faker::Lorem.word }
    disabled    false
    registry    { create(:registry) }
    project     { create(:project) }
    release     { create(:release) }
    component   { create(:component, project: project) }
  end
end
