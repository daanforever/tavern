class Instance < ActiveRecord::Base
  belongs_to :image
  belongs_to :component
  belongs_to :host
end
