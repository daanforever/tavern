# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  disabled     :boolean
#  project_id   :integer
#  release_id   :integer
#  component_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  docker_id    :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    name          { Faker::Lorem.word }
    disabled      false
    registries    { [ create(:registry) ] }
    project       { create(:project) }
    release       { create(:release) }
    component     { create(:component, project: project) }
    docker_id     { 64.times.map{ rand(0xf).to_s(16) }.join }
  end
end
