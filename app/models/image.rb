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
#  docker_image :string(255)
#

class Image < ActiveRecord::Base
  has_and_belongs_to_many :registries
  belongs_to :project
  belongs_to :release
  belongs_to :component
end
