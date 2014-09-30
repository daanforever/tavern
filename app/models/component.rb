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

class Component < ActiveRecord::Base
  has_and_belongs_to_many :releases
  has_many                :images
  belongs_to              :project
  # has_many :instances

  def self.find_or_create!(project: project, release: release, name: name)
    if component = Component.find_by(project: project, name: name)
      release.components << component unless release.components.find_by(name: name)
      component
    else
      release.components.create!(project: project, name: name)
    end
  end
end
