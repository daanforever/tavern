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

class Image < ActiveRecord::Base
  belongs_to :registry
  belongs_to :project
  belongs_to :release
  belongs_to :component
end
