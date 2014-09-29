class Image < ActiveRecord::Base
  belongs_to :registry
  belongs_to :project
  belongs_to :release
  belongs_to :component
end
