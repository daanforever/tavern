class Project < ActiveRecord::Base
  has_and_belongs_to_many :registries
  # has_and_belongs_to_many :releases
end
