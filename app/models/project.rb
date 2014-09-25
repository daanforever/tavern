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
  has_and_belongs_to_many :registries
  has_many :releases
end
