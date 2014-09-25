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
#

class Component < ActiveRecord::Base
  has_and_belongs_to_many :releases
  # has_many :instances
end
