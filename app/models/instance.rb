# == Schema Information
#
# Table name: instances
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  disabled     :boolean
#  port         :integer
#  container    :string(255)
#  properties   :text
#  image_id     :integer
#  component_id :integer
#  host_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Instance < ActiveRecord::Base
  belongs_to :image
  belongs_to :component
  belongs_to :host
end
