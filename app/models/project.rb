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

class Project < ActiveRecord::Base

  has_many :environments
  has_many :releases
  has_many :components
  has_many :images

  before_save :set_label

  protected
  def set_label
    self.label ||= self.name
  end
end
