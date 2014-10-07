class Environment < ActiveRecord::Base
  belongs_to :project
  belongs_to :release
  has_many   :hosts
  has_many   :instances
end
