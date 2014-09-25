# == Schema Information
#
# Table name: releases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

class Release < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :components
end
