# == Schema Information
#
# Table name: environments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  release_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Environment < ActiveRecord::Base
  belongs_to :project, counter_cache: :environments_count
  belongs_to :release
  has_many   :hosts
  has_many   :instances

  validates  :name, :release, :project, presence: true

end
