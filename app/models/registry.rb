class Registry < ActiveRecord::Base
  validates :url, presence: true
end
