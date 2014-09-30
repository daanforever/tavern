# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  disabled    :boolean
#  info        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Host < ActiveRecord::Base
  has_many :instances
  validates :url, presence: true
  before_validation :set_name
  validates :name, uniqueness: true

  protected 
  def set_name
    self.name = URI.parse(self.url).host if self.name.blank?
  end
end
